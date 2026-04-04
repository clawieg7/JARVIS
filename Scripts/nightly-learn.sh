#!/bin/bash
# Nightly self-improvement loop voor Jarvis
# Draait via remote control tmux sessie
# Activeert de self-optimize meta-agent

JARVIS_DIR="/Users/jarvis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault/Development/Projects/In progress/Jarvis"
LOG="$HOME/scripts/logs/nightly-learn.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

echo "[$TIMESTAMP] [INFO] Nightly learn loop gestart" >> "$LOG"

# Stap 1: Check nieuwe podcast episodes (draait standalone, geen Claude nodig)
echo "[$TIMESTAMP] [INFO] Podcast check starten..." >> "$LOG"
bash "$JARVIS_DIR/Scripts/check-podcasts.sh" >> "$LOG" 2>&1

# Stap 2: Check of claude-rc tmux sessie draait voor deep analyse
if ! tmux has-session -t claude-rc 2>/dev/null; then
  echo "[$TIMESTAMP] [WARN] claude-rc sessie niet actief, skip deep analysis" >> "$LOG"
  exit 0
fi

# Stap 3: Stuur het self-optimize commando naar de remote control sessie
tmux send-keys -t claude-rc "Lees self-optimize.md en voer de nachtelijke research & learning loop uit. Focus op: 1) failure traces analyseren 2) nieuwe podcast episodes analyseren, fact-checken en key inzichten via Telegram delen 3) klopping.nl scannen op nieuwe tools/tips 4) GitHub trending scannen 5) één nieuwe skill of verbetering integreren 6) rapportage klaarzetten voor morning briefing. Werk autonoom door tot 06:00." Enter

echo "[$TIMESTAMP] [INFO] Self-optimize commando verstuurd naar claude-rc" >> "$LOG"
