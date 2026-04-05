# Hooks

Claude Code hooks voor het Jarvis project. Hooks worden uitgevoerd door de Claude Code harness — niet door Claude zelf.

## Beschikbare hooks

### `pre-write-security.sh`

**Type:** PreToolUse — Write, Edit

Beveiligt schrijfoperaties met twee checks:

1. **Werkgebied check** — Weigert schrijven buiten `Development/` in de vault (en `Projects/🧠 Kennis/` als uitzondering voor kennis-content). Exit 2 met foutmelding als het pad buiten scope valt.

2. **Secret detection** — Scant de te schrijven content op patronen die op secrets wijzen: API keys (OpenAI, Anthropic, AWS), tokens, passwords, private keys, bot tokens. Exit 2 met foutmelding als een patroon gevonden wordt.

Logs naar `~/.jarvis/logs/security.log`.

---

### `post-bash-trace.sh`

**Type:** PostToolUse — Bash

Logt elke uitgevoerde bash command naar `~/.jarvis/logs/bash-trace.log` met:
- Timestamp in ISO 8601
- Log type: `INFO` (exit 0) of `WARN` (exit ≠ 0)
- Exit code
- Eerste 500 tekens van het commando

Automatische log rotatie bij >10MB (archiveert naar `bash-trace-YYYYMMDDHHMMSS.log`).

---

## Activeren in `.claude/settings.json`

Voeg het volgende toe aan `.claude/settings.json` in de projectroot (of `~/.claude/settings.json` voor globale werking):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "/pad/naar/vault/Development/Projects/In progress/Jarvis/Hooks/pre-write-security.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "/pad/naar/vault/Development/Projects/In progress/Jarvis/Hooks/post-bash-trace.sh"
          }
        ]
      }
    ]
  }
}
```

Vervang het pad door het absolute pad naar de Hooks directory op jouw machine. Omdat de vault in iCloud zit, is het pad:

```
/Users/jarvis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault/Development/Projects/In progress/Jarvis/Hooks/
```

> Tip: gebruik de `update-config` skill om hooks via Claude Code te configureren.

---

## Rechten

Beide scripts moeten uitvoerbaar zijn:

```bash
chmod +x pre-write-security.sh post-bash-trace.sh
```

---

## Log locaties

| Log | Inhoud |
|-----|--------|
| `~/.jarvis/logs/bash-trace.log` | Alle uitgevoerde bash commands |
| `~/.jarvis/logs/security.log` | Geblokkeerde schrijfpogingen en gevonden secrets |

Conform `logging.md`: format `[ISO8601] [TYPE] bericht`, rotatie bij >10MB.
