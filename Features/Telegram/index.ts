import "dotenv/config";
import { Bot, Context, GrammyError, HttpError } from "grammy";
import { autoRetry } from "@grammyjs/auto-retry";
import { run, sequentialize } from "@grammyjs/runner";
import { appendFileSync, mkdirSync } from "fs";
import { chat, reset } from "./claude.js";

// ── Logging ──────────────────────────────────────────────

const LOG_DIR = `${process.env.HOME}/Claude/logs`;
mkdirSync(LOG_DIR, { recursive: true });

type LogLevel = "INFO" | "WARN" | "ERROR" | "DEBUG";

function log(level: LogLevel, msg: string, data?: unknown): void {
  const ts = new Date().toISOString();
  const line = data
    ? `[${ts}] [${level}] ${msg} ${JSON.stringify(data)}`
    : `[${ts}] [${level}] ${msg}`;
  console.log(line);
  try {
    appendFileSync(`${LOG_DIR}/telegram-bot.log`, line + "\n");
  } catch {}
}

function logError(msg: string, err: unknown): void {
  const detail = err instanceof Error
    ? { message: err.message, stack: err.stack?.split("\n").slice(0, 5) }
    : err;
  log("ERROR", msg, detail);
}

// ── Config ───────────────────────────────────────────────

const token = process.env.TELEGRAM_BOT_TOKEN;
if (!token) {
  log("ERROR", "TELEGRAM_BOT_TOKEN ontbreekt in .env — bot kan niet starten");
  process.exit(1);
}

const allowedUsers = new Set(
  (process.env.TELEGRAM_ALLOWED_USERS ?? "")
    .split(",")
    .map((id) => Number(id.trim()))
    .filter((id) => id > 0)
);

if (allowedUsers.size === 0) {
  log("WARN", "TELEGRAM_ALLOWED_USERS niet gezet — bot is open voor iedereen!");
}

function isAllowed(ctx: Context): boolean {
  if (allowedUsers.size === 0) return true;
  return ctx.from !== undefined && allowedUsers.has(ctx.from.id);
}

// ── Message splitting ────────────────────────────────────

const MAX_MSG_LENGTH = 4096;

async function sendLongMessage(ctx: Context, text: string): Promise<void> {
  if (text.length <= MAX_MSG_LENGTH) {
    await ctx.reply(text);
    return;
  }

  const chunks: string[] = [];
  let remaining = text;
  while (remaining.length > 0) {
    if (remaining.length <= MAX_MSG_LENGTH) {
      chunks.push(remaining);
      break;
    }
    let splitAt = remaining.lastIndexOf("\n\n", MAX_MSG_LENGTH);
    if (splitAt === -1 || splitAt < MAX_MSG_LENGTH * 0.5) {
      splitAt = remaining.lastIndexOf("\n", MAX_MSG_LENGTH);
    }
    if (splitAt === -1 || splitAt < MAX_MSG_LENGTH * 0.3) {
      splitAt = remaining.lastIndexOf(" ", MAX_MSG_LENGTH);
    }
    if (splitAt === -1) splitAt = MAX_MSG_LENGTH;
    chunks.push(remaining.slice(0, splitAt));
    remaining = remaining.slice(splitAt).trimStart();
  }

  log("DEBUG", `Bericht gesplit in ${chunks.length} chunks (totaal ${text.length} chars)`);
  for (const chunk of chunks) {
    await ctx.reply(chunk);
  }
}

// ── Bot setup ────────────────────────────────────────────

const bot = new Bot(token);

bot.api.config.use(autoRetry({ maxRetryAttempts: 3, maxDelaySeconds: 60 }));

bot.use(sequentialize((ctx) => {
  const chatId = ctx.chat?.id.toString();
  return chatId ? [chatId] : [];
}));

// Auth middleware
bot.use(async (ctx, next) => {
  if (!isAllowed(ctx)) {
    log("WARN", `Geblokkeerd: user ${ctx.from?.id} (${ctx.from?.first_name})`);
    return;
  }
  await next();
});

// ── Commands ─────────────────────────────────────────────

bot.command("start", (ctx) => {
  log("INFO", `/start van user ${ctx.from?.id}`);
  return ctx.reply("JARVIS online. Wat kan ik voor je doen?");
});

bot.command("reset", (ctx) => {
  if (!ctx.from) return;
  reset(ctx.from.id);
  log("INFO", `/reset van user ${ctx.from.id}`);
  return ctx.reply("Geheugen gewist.");
});

bot.command("status", (ctx) => {
  const uptime = process.uptime();
  const mem = process.memoryUsage();
  const h = Math.floor(uptime / 3600);
  const m = Math.floor((uptime % 3600) / 60);
  const status = [
    `Uptime: ${h}u ${m}m`,
    `Memory: ${Math.round(mem.heapUsed / 1024 / 1024)}MB`,
    `PID: ${process.pid}`,
  ].join("\n");
  log("INFO", `/status van user ${ctx.from?.id}`);
  return ctx.reply(status);
});

// ── Message handler ──────────────────────────────────────

bot.on("message:text", async (ctx) => {
  const userId = ctx.from.id;
  const text = ctx.message.text;
  const startTime = Date.now();

  log("INFO", `Bericht ontvangen`, { userId, chars: text.length, preview: text.slice(0, 80) });

  const typing = setInterval(() => {
    ctx.replyWithChatAction("typing").catch(() => {});
  }, 4000);
  await ctx.replyWithChatAction("typing").catch(() => {});

  try {
    const reply = await chat(userId, text);
    const duration = Date.now() - startTime;
    log("INFO", `Antwoord verzonden`, { userId, chars: reply.length, durationMs: duration });
    await sendLongMessage(ctx, reply);
  } catch (err) {
    const duration = Date.now() - startTime;
    logError(`Chat error na ${duration}ms voor user ${userId}`, err);

    const errMsg = err instanceof Error ? err.message : String(err);

    // Geef gebruiker bruikbare feedback
    if (errMsg.includes("401") || errMsg.includes("authentication")) {
      await ctx.reply("⚠️ API authenticatie mislukt. Check ANTHROPIC_API_KEY.");
    } else if (errMsg.includes("429") || errMsg.includes("rate")) {
      await ctx.reply("⚠️ Rate limit bereikt. Probeer over een minuut opnieuw.");
    } else if (errMsg.includes("timeout") || errMsg.includes("ETIMEDOUT")) {
      await ctx.reply("⚠️ Timeout — Claude reageerde niet op tijd. Probeer opnieuw.");
    } else if (errMsg.includes("overloaded")) {
      await ctx.reply("⚠️ Claude is overbelast. Probeer over een paar minuten.");
    } else {
      await ctx.reply(`⚠️ Fout: ${errMsg.slice(0, 200)}`);
    }
  } finally {
    clearInterval(typing);
  }
});

// ── Error handling ───────────────────────────────────────

bot.catch((err) => {
  const ctx = err.ctx;
  const e = err.error;

  if (e instanceof GrammyError) {
    if (e.error_code === 409) {
      log("ERROR", "CONFLICT: Er draait een andere bot op dezelfde token! Stop de andere instantie.");
      process.exit(1);
    }
    log("ERROR", `Telegram API error`, { code: e.error_code, description: e.description });
  } else if (e instanceof HttpError) {
    logError("Network error", e);
  } else {
    logError("Onverwachte fout", e);
  }
});

// ── Startup ──────────────────────────────────────────────

log("INFO", "JARVIS Telegram bot wordt gestart...", {
  pid: process.pid,
  node: process.version,
  allowedUsers: [...allowedUsers],
});

const handle = run(bot);

log("INFO", "JARVIS Telegram bot gestart (polling actief)");

const stop = () => {
  log("INFO", "Bot wordt gestopt...");
  if (handle.isRunning()) {
    handle.stop();
  }
};

process.once("SIGINT", stop);
process.once("SIGTERM", stop);

// Uncaught errors — log en crash clean
process.on("uncaughtException", (err) => {
  logError("UNCAUGHT EXCEPTION", err);
  stop();
  process.exit(1);
});

process.on("unhandledRejection", (reason) => {
  logError("UNHANDLED REJECTION", reason);
});
