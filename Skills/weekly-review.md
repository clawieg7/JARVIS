# Skill: Weekly Review

## Doel
Wekelijks overzicht genereren op zondag 18:00 en via Telegram versturen.

## Trigger
Remote trigger: `Weekly Review`
- Schema: `0 16 * * 0` (18:00 CET, zondag)
- Model: claude-sonnet-4-6

## Componenten

### 1. Backup status
```bash
# Vault backup status deze week
grep "$(date -v-7d +%Y-%m)" ~/scripts/logs/vault-backup.log | tail -14

# Projects backup status deze week
grep "$(date -v-7d +%Y-%m)" ~/scripts/logs/projects-backup.log | tail -14
```

### 2. Things taken overzicht
```bash
THINGS_DB="$HOME/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite"

# Afgerond deze week
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=3 AND stopDate IS NOT NULL AND date(stopDate, 'unixepoch', '+31 years') >= date('now', '-7 days') AND trashed=0 ORDER BY stopDate;"

# Gemiste taken (stale >7 dagen)
sqlite3 "$THINGS_DB" "SELECT title, date(startDate, 'unixepoch', '+31 years') as added FROM TMTask WHERE status=0 AND startDate IS NOT NULL AND trashed=0 AND startDate < strftime('%s', 'now', '-7 days', '-31 years') ORDER BY startDate;"
```

### 3. Git activiteit deze week
```bash
for dir in ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ vault/Development/Projects/In\ progress/*/; do
  if [ -d "$dir/.git" ]; then
    count=$(git -C "$dir" log --since="7 days ago" --oneline 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -gt 0 ]; then
      echo "$(basename "$dir"): $count commits"
      git -C "$dir" log --since="7 days ago" --format="  - %s" 2>/dev/null
    fi
  fi
done
```

### 4. Health check
```bash
~/Claude/scripts/health-check.sh
```

### 5. Failure traces analyse
```bash
# Traces van deze week
traces_dir="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault/Development/Projects/In progress/Jarvis/Data/traces"
for f in "$traces_dir"/$(date -v-7d +%Y-%m)*.jsonl; do
  [ -f "$f" ] && cat "$f"
done
```

### 6. Verstuur via Telegram
```bash
~/Claude/scripts/notify-telegram.sh "$REVIEW"
```

## Output formaat
```
Weekoverzicht — week [nr], [datum]

GOED GEGAAN
1. [concreet resultaat]
2. [concreet resultaat]
3. [concreet resultaat]

TE VERBETEREN
1. [concreet punt + actie]
2. [concreet punt + actie]
3. [concreet punt + actie]

HIGHLIGHTS
- [opvallend uit chats/taken]
- [opvallend uit chats/taken]

GEMISTE TAKEN
- [taak] (stale sinds [datum])
- [taak] (stale sinds [datum])

GIT ACTIVITEIT
[project]: [X] commits
[project]: [X] commits
Totaal: [X] commits

BACKUPS: [OK / problemen]
HEALTH: [OK / problemen]

VOLGENDE WEEK
- [prioriteit 1]
- [prioriteit 2]
- [prioriteit 3]
```

## Analyse richtlijnen
- **Goed gegaan**: baseer op afgeronde taken, succesvolle deploys, opgeloste issues
- **Te verbeteren**: baseer op failure traces, stale taken, gemiste deadlines
- **Highlights**: opvallende chats, nieuwe inzichten, interessante ontdekkingen
- **Volgende week**: baseer op open taken, upcoming deadlines, lopende projecten

## Chaining
- Voor deze review: `backup-status` + `things-sync` + `health-check`
- Na deze review: Telegram

### Chain
```
cron -> backup-status -> things-sync -> health-check -> weekly-review -> Telegram
```

## Afhankelijkheden
- Things 3 database beschikbaar
- Git repos in Development/Projects/In progress/
- Backup logs in ~/scripts/logs/
- health-check.sh script
- notify-telegram.sh script
- Telegram bot actief
- Failure traces in Data/traces/ (optioneel)
