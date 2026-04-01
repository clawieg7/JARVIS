import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic();

type Message = { role: "user" | "assistant"; content: string };
const history = new Map<number, Message[]>();

const SYSTEM = `Je bent JARVIS, de persoonlijke AI-assistent van Gijs.
Gebaseerd op JARVIS (Iron Man) en TARS (Interstellar): proactief, efficiënt, droog, direct.
Communiceer altijd in het Nederlands. Geen filler, geen overbodige complimenten.
Wees proactief — signaleer risico's en kansen zonder ernaar gevraagd te worden.`;

export async function chat(userId: number, message: string): Promise<string> {
  const messages = history.get(userId) ?? [];
  messages.push({ role: "user", content: message });

  const response = await client.messages.create({
    model: "claude-sonnet-4-6",
    max_tokens: 1024,
    system: SYSTEM,
    messages,
  });

  const reply = response.content[0].type === "text" ? response.content[0].text : "—";
  messages.push({ role: "assistant", content: reply });
  history.set(userId, messages);

  return reply;
}

export function reset(userId: number): void {
  history.delete(userId);
}
