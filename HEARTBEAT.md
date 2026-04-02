# Jarvis Heartbeat

Laatste update: 2026-04-03 00:57 CET

---

## Systeem

- Mac Mini M4 16GB — uptime: 2 days
- Tailscale: 100.82.231.116
- SSH: actief
- Disk: 8%

## Services

- jarvis tmux (Telegram) — ACTIEF
- claude-rc tmux (Remote Control) — ACTIEF
- caffeinate — ACTIEF
- file watcher — ACTIEF
- watchdog cron — elke 30 min

## LaunchAgents (8)

- com.jarvis.projects-backup — scheduled
- com.jarvis.caffeinate — PID 
- com.jarvis.safe-reboot — scheduled
- com.jarvis.telegram — PID 
- com.jarvis.claude-remote-control — PID 
- com.jarvis.daily-note — scheduled
- com.jarvis.watcher — PID 
- com.jarvis.vault-backup — scheduled
- com.jarvis.event-notifier — PID 

## Remote Triggers (cloud)

- Morning Briefing — 07:00 CET dagelijks
- Daily Report — 17:00 CET dagelijks
- Weekly Review — zondag 18:00 CET

## MCP Servers

Lokaal: Apple, Obsidian, Playwright, Things 3
Cloud: Gmail, Calendar, Supabase, Vercel, Figma, Context7, Canva, Hugging Face, Granted

## Communicatiekanalen

1. Telegram (@JarvisCode7_Bot)
2. Terminal: tmux attach -t jarvis
3. SSH: ssh jarvis@100.82.231.116
4. Remote Control: claude.ai/code
5. Obsidian inbox.md → file watcher

## Bekende beperkingen

- FileVault aan — herstart vereist 1x wachtwoord
- Calendar permissions nodig voor icalBuddy
