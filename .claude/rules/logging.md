# Regels: Logging

## Format
Elke log entry heeft ALTIJD:
- **Datum + tijd** in ISO 8601: `[2026-04-03T02:15:00Z]`
- **Type**: `INFO`, `WARN`, `ERROR`, `DEBUG`
- **Bericht**: kort, concreet

Voorbeeld:
```
[2026-04-03T02:15:00Z] [INFO] Telegram bot gestart (PID 12345)
[2026-04-03T02:15:05Z] [ERROR] Claude API timeout na 30s voor user 5775310956
[2026-04-03T02:15:10Z] [WARN] Caffeinate niet actief, herstart poging
```

## Locatie
- Alle systeem logs: `~/.jarvis/logs/`
- Geen logs in `~/Claude/` (verouderd)
- Geen dubbele log locaties
- Project-specifieke data: `Data/` map in elk project

## Regels
- Geen logs zonder timestamp
- Geen errors zonder type
- Log rotatie bij >10MB (watchdog doet dit)
- Gevoelige data (tokens, wachtwoorden) NOOIT loggen
