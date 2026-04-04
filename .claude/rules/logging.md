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

## Failure Traces (uit AutoAgent: "traces are everything")

Bij elke fout of suboptimaal resultaat, log een **failure trace**:

```
[2026-04-03T07:00:00Z] [TRACE] {
  "task": "instagram scrape DWoh0-hjnMi",
  "expected": "$50,000 portfolio",
  "actual": "$100 portfolio",
  "root_cause": "meta tag og:image geeft alleen slide 1 thumbnail, tekst onleesbaar bij 640x640",
  "fix_applied": "verificatiestap toegevoegd aan skill, data gecorrigeerd",
  "prevention": "nooit cijfers vertrouwen van thumbnails, altijd markeren als ONBEVESTIGD"
}
```

### Waarom traces
- Zonder trajectories daalt improvement rate (AutoAgent bewijs)
- "Waarom" is belangrijker dan "dat" iets fout ging
- Meta-agent kan traces analyseren en harness verbeteren
- Traces → patronen → nieuwe regels/skills

### Trace locatie
- `Data/traces/` — gestructureerde failure traces per datum
- Format: JSONL (één JSON object per regel)
- Bewaar minimaal 30 dagen
