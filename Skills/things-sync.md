# Skill: Things Sync

## Doel
Taken ophalen uit Things 3 via directe SQLite database access.

## Database pad
```
~/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite
```

## Commando's

### Vandaag taken
```bash
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=0 AND startDate IS NOT NULL AND trashed=0 ORDER BY todayIndex;"
```

### Inbox
```bash
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=0 AND start=0 AND trashed=0 ORDER BY creationDate DESC;"
```

### Binnenkort
```bash
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=0 AND start=1 AND startDate IS NULL AND trashed=0;"
```

### Stale taken (>7 dagen in Today)
```bash
sqlite3 "$THINGS_DB" "SELECT title, date(startDate, 'unixepoch', '+31 years') as added FROM TMTask WHERE status=0 AND startDate IS NOT NULL AND trashed=0 AND startDate < strftime('%s', 'now', '-7 days', '-31 years') ORDER BY startDate;"
```

### Vandaag afgerond
```bash
sqlite3 "$THINGS_DB" "SELECT title FROM TMTask WHERE status=3 AND stopDate IS NOT NULL AND date(stopDate, 'unixepoch', '+31 years') = date('now') AND trashed=0;"
```

## Variabele
```bash
THINGS_DB="$HOME/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite"
```

## Notities
- AppleScript timeout issues → SQLite is betrouwbaarder
- Database is read-only (Things schrijft, wij lezen)
- Things 3 epoch: +31 jaar offset op Unix epoch

## Ketent naar
- morning-briefing → daily-report
