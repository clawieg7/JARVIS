# Feature: Telegram

Entrypoint voor Jarvis. Ontvangt berichten van Gijs via Telegram en stuurt ze naar Claude. Antwoord gaat terug als Telegram-bericht.

## Uitvoeren
```bash
npm run telegram
```

## Architectuur
- `index.ts` — bot setup, message routing
- `claude.ts` — Claude API integratie + conversation memory
- Polling (geen webhook) — geschikt voor lokaal draaien

## Gedrag
- Elke gebruiker krijgt een eigen conversatiegeschiedenis (in-memory)
- `/start` — welkomstbericht
- `/reset` — wis conversatiegeschiedenis
- Elk ander bericht → naar Claude → antwoord terug

## Uitbreiden
Nieuwe features koppel je door in `index.ts` te detecteren op intentie of commando.
