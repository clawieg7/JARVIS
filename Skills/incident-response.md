# Skill: Incident Response

## Bij token/secret lek
1. **Revoke** de key/token ONMIDDELLIJK (eerst dit, dan onderzoeken)
2. Genereer nieuwe credentials
3. Check git history: `git log --all -p | grep -i "<gelekte key>"`
4. Verwijder uit history als nodig (bfg of git filter-branch)
5. Update alle .env bestanden
6. Verifieer services draaien met nieuwe tokens

## Bij service down
1. `bash ~/Claude/scripts/health-check.sh` — welke service is down?
2. Check logs: `tail -50 ~/Claude/logs/<service>.log`
3. Herstart via: `launchctl kickstart -k gui/$(id -u)/com.jarvis.<service>`
4. Als tmux sessie down: `bash ~/.jarvis/scripts/jarvis-telegram.sh &`
5. Verifieer: `bash ~/Claude/scripts/health-check.sh`

## Bij Mac herstart/crash
1. Alle LaunchAgents starten automatisch (RunAtLoad: true)
2. Check: `launchctl list | grep jarvis`
3. Als tmux sessies weg: watchdog herstart jarvis binnen 30 min
4. Handmatig: `bash ~/.jarvis/scripts/jarvis-telegram.sh &`

## Bij Telegram niet bereikbaar
1. Check tmux: `/opt/homebrew/bin/tmux has-session -t jarvis`
2. Check plugin: `pgrep -fl "bun.*telegram"`
3. Check token: `cat ~/.claude/channels/telegram/.env`
4. Herstart: kill tmux → herstart script
5. Fallback: ntfy.sh notificatie channel

## Contactkanalen (prioriteit)
1. Telegram (@JarvisCode7_Bot)
2. iMessage (`~/.jarvis/scripts/notify-imessage.sh "bericht"`)
3. Terminal (tmux attach -t jarvis)
4. SSH (ssh jarvis@100.82.231.116)
5. ntfy.sh (backup)
