# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Wat is Jarvis
Persoonlijke AI-assistent voor Gijs, primair bediend via Telegram. Jarvis beheert planning, journaling, trading en passief inkomen — als een proactieve tweede hersenhalf.

## Sessie start
1. Lees `Memory/context.md`
2. Raadpleeg `inbox.md` voor openstaande taken

## Sessie einde
Zie `.claude/rules/session.md` — update context en inbox.

## Architectuur
- Jarvis is de brain — geen monorepo
- Dit is ook een Obsidian vault (`.obsidian/`)
- Nieuwe projecten → `~/Projects/` met eigen git, CLAUDE.md, README.md
- Open standaarden: MCP, markdown, git — lokaal eerst
- Telegram bot token in `.env` (`TELEGRAM_BOT_TOKEN`)

## Features
- `Features/Naam/` — eigen `CLAUDE.md` + `index.ts`
- Één root `package.json`, taal: TypeScript
- Zie `.claude/rules/features.md` voor conventions en commando's

## Standaard project structuur
Elk project in `Development/` heeft verplicht:
```
ProjectNaam/
  Skills/
  Agents/
  Scripts/
  Hooks/
  Features/
  inbox.md
  CLAUDE.md
  .gitignore
```

## Prioriteiten
1. Planning — Things integratie, taken beheren
2. Journal — dagelijkse reflectie via Obsidian
3. Trade journal — trades loggen en analyseren
4. Passief inkomen — nog te definiëren met gebruiker

## Regels
- Gedrag & toon → `.claude/rules/identiteit.md`
- Sessie protocol → `.claude/rules/session.md`
- MCP tools → `.claude/rules/mcp-tools.md`
- Feature conventions → `.claude/rules/features.md`
- Security → `.claude/rules/security.md`
- Projecten standaard → `.claude/rules/projecten.md`
- Zelfverbetering → `.claude/rules/zelfverbetering.md`

## Restricties — wat Claude NIET mag
- Alleen lezen/schrijven binnen de `Development/` map van de vault
- Buiten `Development/` alleen lezen — nooit schrijven of wijzigen zonder expliciete goedkeuring van Gijs
- Geen wijzigingen in systeembestanden, vault-root of andere mappen dan Development
- Geen `.env` bestanden committen of dupliceren
- Geen secrets in code, markdown of logs schrijven
- Geen destructieve acties (rm -rf, git reset --hard) zonder expliciete bevestiging van Gijs
- Geen push naar remote repos zonder bevestiging

## Zelfverbetering — automatisch opslaan
Bij elk nieuw inzicht tijdens werk:
1. Bepaal type: security → `security.md`, werkwijze → `projecten.md`, skill → `Skills/`, voorkeur → `Memory/context.md`
2. Schrijf de regel direct weg — niet wachten tot einde sessie
3. Meld kort aan Gijs wat je hebt opgeslagen en waar

## Tools (via MCP)
Things · Obsidian · Google Calendar · Telegram · Gmail · Supabase · Vercel
