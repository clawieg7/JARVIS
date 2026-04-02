# Skill: Backup Status

## Doel
Status van alle backup systemen checken.

## Commando's

### Vault backup
```bash
grep "$(date +%Y-%m-%d)" ~/scripts/logs/vault-backup.log | tail -5
```

### Projects backup
```bash
grep "$(date +%Y-%m-%d)" ~/scripts/logs/projects-backup.log | tail -10
```

### Laatste commit per project
```bash
for dir in ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ vault/Development/In\ progress/*/; do
  if [ -d "$dir/.git" ]; then
    echo "$(basename "$dir"): $(git -C "$dir" log -1 --format='%ar — %s' 2>/dev/null)"
  fi
done
```

## Schema
- Vault backup: 09:00 + 18:00
- Projects backup: 09:30 + 18:30

## Ketent naar
- health-check → weekly-review
