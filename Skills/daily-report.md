# Skill: Daily Report

## Doel
Dagelijks rapport genereren om 17:00 en via Telegram versturen.

## Trigger
Remote trigger: `Daily Report`
- Schema: `0 15 * * *` (17:00 CET)
- Model: claude-sonnet-4-6

## Componenten

### 1. Things taken status
```bash
THINGS_DB="$HOME/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite"

# Vandaag afgerond
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=3 AND stopDate IS NOT NULL AND date(stopDate, 'unixepoch', '+31 years') = date('now') AND trashed=0;"

# Nog open vandaag
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=0 AND startDate IS NOT NULL AND trashed=0 ORDER BY todayIndex;"

# Upcoming (morgen/binnenkort)
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=0 AND start=1 AND startDate IS NULL AND trashed=0 LIMIT 10;"
```

### 2. Git activiteit vandaag
```bash
for dir in ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ vault/Development/Projects/In\ progress/*/; do
  if [ -d "$dir/.git" ]; then
    commits=$(git -C "$dir" log --since="today 00:00" --oneline 2>/dev/null)
    if [ -n "$commits" ]; then
      echo "$(basename "$dir"):"
      echo "$commits"
    fi
  fi
done
```

### 3. Health check status
```bash
~/Claude/scripts/health-check.sh
```

### 4. Verstuur via Telegram
```bash
~/Claude/scripts/notify-telegram.sh "$REPORT"
```

## Output formaat
```
Dagrapport — [dag] [datum]

AFGEROND ([X])
- [taak]
- [taak]

NOG OPEN ([X])
- [taak]
- [taak]

GIT ACTIVITEIT
[project]: [X] commits
[project]: [X] commits

HEALTH: [OK / X problemen]

MORGEN
- [taak]
- [taak]
```

## Chaining
- Voor dit rapport: `things-sync` + `git-log`
- Na dit rapport: Telegram

### Chain
```
cron -> things-sync -> git-log -> daily-report -> Telegram
```

## Afhankelijkheden
- Things 3 database beschikbaar
- Git repos in Development/Projects/In progress/
- health-check.sh script
- notify-telegram.sh script
- Telegram bot actief
