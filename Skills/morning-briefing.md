# Skill: Morning Briefing

## Doel
Dagelijkse ochtendbriefing samenstellen en via Telegram sturen.

## Componenten
1. **Weer** — `curl -s 'wttr.in/Den+Haag?format=%C+%t+%w&lang=nl'`
2. **Agenda** — Google Calendar MCP: events vandaag + morgen
3. **Taken** — Things 3 SQLite: Today lijst + stale detectie
4. **Health** — `~/Claude/scripts/health-check.sh`
5. **Mail** — Gmail MCP: ongelezen ACTIE mails (optioneel)

## Trigger
Remote trigger: `Morning Briefing + Dag Coach`
- Schema: `0 5 * * *` (07:00 CET)
- Model: claude-sonnet-4-6

## Output formaat
```
Goedemorgen — [dag] [datum]

[weer] | [X] afspraken | [X] taken

AGENDA
[events met tijden]

TAKEN (geschatte duur)
• [taak] — [X] min
• [taak] — [X] min

[STALE: taak staat er al X dagen]
[HEALTH: X problemen]

COACHING: [1 zin]
```

## Ketent naar
- things-sync → health-check
