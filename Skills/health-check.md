# Skill: Health Check

## Doel
Alle Jarvis services verifiëren in één commando.

## Commando
```bash
~/Claude/scripts/health-check.sh
```

## Wat wordt gecheckt
- Telegram tmux sessie (jarvis)
- Remote Control tmux sessie (claude-rc)
- Caffeinate (sleep prevention)
- File Watcher
- Alle LaunchAgents (6 stuks)
- Disk usage (<85%)
- Tailscale verbinding
- Recente errors in logs

## Met alert
```bash
~/Claude/scripts/health-check.sh --alert
```
Stuurt Telegram notificatie bij problemen.

## Watchdog
Automatische versie draait elke 30 min via cron:
```bash
~/Claude/scripts/watchdog.sh
```
Herstart jarvis tmux sessie als die down is.

## Ketent naar
- morning-briefing (health status in ochtendbericht)
