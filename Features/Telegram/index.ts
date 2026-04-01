import "dotenv/config";
import { Bot } from "grammy";
import { chat, reset } from "./claude.js";

const token = process.env.TELEGRAM_BOT_TOKEN;
if (!token) throw new Error("TELEGRAM_BOT_TOKEN ontbreekt in .env");

const bot = new Bot(token);

bot.command("start", (ctx) =>
  ctx.reply("JARVIS online. Wat kan ik voor je doen?")
);

bot.command("reset", (ctx) => {
  if (!ctx.from) return;
  reset(ctx.from.id);
  ctx.reply("Geheugen gewist.");
});

bot.on("message:text", async (ctx) => {
  const userId = ctx.from.id;
  const text = ctx.message.text;

  const typing = setInterval(() => ctx.replyWithChatAction("typing"), 4000);
  await ctx.replyWithChatAction("typing");

  try {
    const reply = await chat(userId, text);
    clearInterval(typing);
    await ctx.reply(reply);
  } catch (err) {
    clearInterval(typing);
    console.error(err);
    await ctx.reply("Fout opgetreden. Probeer opnieuw.");
  }
});

bot.catch((err) => console.error("Bot error:", err));

console.log("JARVIS Telegram bot gestart (polling)...");
bot.start();
