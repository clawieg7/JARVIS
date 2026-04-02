import Anthropic from "@anthropic-ai/sdk";

// Ondersteun zowel ANTHROPIC_API_KEY als CLAUDE_CODE_OAUTH_TOKEN
const apiKey = process.env.ANTHROPIC_API_KEY;
const oauthToken = process.env.CLAUDE_CODE_OAUTH_TOKEN;

if (!apiKey && !oauthToken) {
  console.error("[CLAUDE] Geen ANTHROPIC_API_KEY of CLAUDE_CODE_OAUTH_TOKEN gevonden in .env");
  process.exit(1);
}

const client = apiKey
  ? new Anthropic({ apiKey })
  : new Anthropic({ authToken: oauthToken });

type Message = { role: "user" | "assistant"; content: string };

interface Conversation {
  messages: Message[];
  lastActivity: number;
}

const conversations = new Map<number, Conversation>();

const MAX_HISTORY = 40;
const STALE_MS = 24 * 60 * 60 * 1000; // 24 uur

const SYSTEM = `Je bent JARVIS, de persoonlijke AI-assistent van Gijs.
Gebaseerd op JARVIS (Iron Man) en TARS (Interstellar): proactief, efficiënt, droog, direct.
Communiceer altijd in het Nederlands. Geen filler, geen overbodige complimenten.
Wees proactief — signaleer risico's en kansen zonder ernaar gevraagd te worden.

## Over Gijs
- Ondernemer / freelancer / developer
- Focus: AI-tools bouwen, passief inkomen, trading
- Voorkeuren: directe communicatie, TypeScript, lokaal-eerst, open standaarden

## Lopende projecten
- Jarvis — dit project, persoonlijke AI-assistent via Telegram
- Trade journal — trades loggen en analyseren
- Passief inkomen — nog te definiëren

## Jouw rol
Je bent Gijs' tweede hersenhalf. Je helpt met:
1. Planning & taken — Things integratie (lokale SQLite db)
2. Journaling — dagelijkse reflectie
3. Trading — trades bijhouden en patronen herkennen
4. Proactief meedenken — signaleer wat Gijs mist

## Stijl
- Kort en bondig, geen essays
- Gebruik bullet points waar mogelijk
- Geef concrete suggesties, geen vage adviezen
- Humor mag, maar niet geforceerd`;

export async function chat(userId: number, message: string): Promise<string> {
  const conv = conversations.get(userId) ?? { messages: [], lastActivity: Date.now() };
  conv.messages.push({ role: "user", content: message });

  if (conv.messages.length > MAX_HISTORY) {
    conv.messages = conv.messages.slice(-MAX_HISTORY);
  }

  const startTime = Date.now();

  try {
    const response = await client.messages.create({
      model: "claude-sonnet-4-6",
      max_tokens: 2048,
      system: SYSTEM,
      messages: conv.messages,
    });

    const duration = Date.now() - startTime;

    if (response.content.length === 0) {
      console.error(`[CLAUDE] Leeg antwoord van API (${duration}ms)`, {
        stopReason: response.stop_reason,
        usage: response.usage,
      });
      // Verwijder het user bericht als we geen antwoord kregen
      conv.messages.pop();
      throw new Error("Claude gaf een leeg antwoord");
    }

    const reply = response.content[0].type === "text" ? response.content[0].text : "—";

    console.log(`[CLAUDE] OK (${duration}ms) stop=${response.stop_reason} in=${response.usage.input_tokens} out=${response.usage.output_tokens}`);

    conv.messages.push({ role: "assistant", content: reply });
    conv.lastActivity = Date.now();
    conversations.set(userId, conv);

    return reply;
  } catch (err) {
    const duration = Date.now() - startTime;

    // Verwijder het user bericht zodat de conversatie niet corrupt raakt
    conv.messages.pop();

    if (err instanceof Anthropic.APIError) {
      console.error(`[CLAUDE] API Error (${duration}ms)`, {
        status: err.status,
        message: err.message,
        headers: err.headers?.["retry-after"],
      });

      if (err.status === 401) throw new Error("authentication failed — check ANTHROPIC_API_KEY");
      if (err.status === 429) throw new Error("rate limit bereikt");
      if (err.status === 529) throw new Error("overloaded — Claude is overbelast");
      if (err.status === 408) throw new Error("timeout — request duurde te lang");
    }

    throw err;
  }
}

export function reset(userId: number): void {
  conversations.delete(userId);
  console.log(`[CLAUDE] Conversatie gewist voor user ${userId}`);
}

// Ruim verlopen conversaties op (elk uur)
setInterval(() => {
  const now = Date.now();
  let cleaned = 0;
  for (const [userId, conv] of conversations) {
    if (now - conv.lastActivity > STALE_MS) {
      conversations.delete(userId);
      cleaned++;
    }
  }
  if (cleaned > 0) {
    console.log(`[CLAUDE] ${cleaned} verlopen conversatie(s) opgeruimd`);
  }
}, 60 * 60 * 1000);
