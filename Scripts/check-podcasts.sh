#!/bin/bash
# Check voor nieuwe podcast episodes, analyseer en stuur via Telegram
# Draait dagelijks via LaunchAgent + als onderdeel van nightly-learn loop

JARVIS_DIR="/Users/jarvis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault/Development/Projects/In progress/Jarvis"
PODCASTS_DIR="$JARVIS_DIR/Data/podcasts"
LOG="$HOME/scripts/logs/podcast-check.log"
NOTIFY="$HOME/.jarvis/scripts/notify-telegram.sh"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

echo "[$TIMESTAMP] [INFO] Podcast check gestart" >> "$LOG"

check_podcast() {
  local name="$1"
  local search_query="$2"
  local podcast_dir="$3"

  # Haal nieuwste episode op via yt-dlp
  local result=$(python3 -m yt_dlp --skip-download --print "%(title)s|||%(upload_date)s|||%(duration_string)s|||%(webpage_url)s" "ytsearch1:$search_query" 2>/dev/null)

  if [ -z "$result" ]; then
    echo "[$TIMESTAMP] [WARN] $name: geen resultaat van YouTube" >> "$LOG"
    return
  fi

  local title=$(echo "$result" | cut -d'|' -f1-1)
  local date=$(echo "$result" | cut -d'|' -f4-4)
  local duration=$(echo "$result" | cut -d'|' -f7-7)
  local url=$(echo "$result" | cut -d'|' -f10-10)

  # Check of we deze al hebben
  if ls "$podcast_dir"/*"$date"* 1>/dev/null 2>&1; then
    echo "[$TIMESTAMP] [INFO] $name: episode $date al verwerkt" >> "$LOG"
    return
  fi

  echo "[$TIMESTAMP] [INFO] $name: NIEUWE EPISODE gevonden — $title ($date)" >> "$LOG"

  # Haal description op (bevat timestamps = topics)
  local desc=$(python3 -m yt_dlp --skip-download --print "%(description).3000s" "$url" 2>/dev/null)
  local formatted_date=$(echo "$date" | sed 's/\(....\)\(..\)\(..\)/\1-\2-\3/')

  # Extract topics uit description timestamps (regels die beginnen met tijdstempel)
  local topics=$(echo "$desc" | grep -E '^\(?[0-9]+:[0-9]+' | head -8 | sed 's/^/  • /')

  # Maak episode bestand
  local safe_title=$(echo "$title" | tr ' /:' '-' | head -c 60)
  local episode_file="$podcast_dir/E-${date}-${safe_title}.md"

  cat > "$episode_file" << EOF
# $title

- Datum: $formatted_date
- Duur: $duration
- Bron: $url
- Status: NIEUW — wacht op deep analyse door Jarvis

## Description
$desc

## Topics
$topics

## Kern
[Wordt aangevuld door nightly learn analyse — fact-check + bronnen]

## Relevant voor Gijs
[Wordt aangevuld — gekoppeld aan projecten/doelen]

## Actiepunten
[Wordt aangevuld — naar juiste inbox]
EOF

  # Bouw Telegram bericht met alles erin
  local tg_msg="🎙️ *Nieuwe $name*

📌 $title
⏱️ $duration | 📅 $formatted_date

📋 *Topics:*
$topics

🔗 $url

⏳ Deep analyse (fact-check + bronnen + actiepunten) volgt zodra Jarvis klaar is"

  # Stuur Telegram notificatie
  if [ -x "$NOTIFY" ]; then
    "$NOTIFY" "$tg_msg" >> "$LOG" 2>&1
  fi

  echo "[$TIMESTAMP] [INFO] $name: notificatie verstuurd, episode opgeslagen" >> "$LOG"

  # Trigger deep analyse via claude-rc als sessie actief is
  if tmux has-session -t claude-rc 2>/dev/null; then
    tmux send-keys -t claude-rc "Nieuwe $name episode: '$title' ($formatted_date). Analyseer: 1) Lees $episode_file 2) Extraheer 3-5 key inzichten 3) Fact-check elk inzicht (zoek bronnen op internet) 4) Bepaal relevantie voor Gijs (welke projecten/doelen) 5) Maak concrete actiepunten → juiste inbox 6) Update episode bestand met analyse 7) Stuur Telegram samenvatting met key inzichten + fact-check status (✅/⚠️/❌) + relevantie + actiepunten" Enter
    echo "[$TIMESTAMP] [INFO] $name: deep analyse getriggerd in claude-rc" >> "$LOG"
  fi
}

# Check beide podcasts
check_podcast "AI Report" "AI Report Alexander Klopping Wietse 2026" "$PODCASTS_DIR/ai-report"
check_podcast "All-In" "All-In Podcast Chamath Sacks Friedberg 2026" "$PODCASTS_DIR/all-in"

echo "[$TIMESTAMP] [INFO] Podcast check voltooid" >> "$LOG"
