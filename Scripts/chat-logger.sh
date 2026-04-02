#!/bin/bash
# chat-logger.sh — Log a chat entry to the daily chat log
# Usage: chat-logger.sh <direction> <user> <message> [category]
#   direction: in | out
#   user: sender name (e.g. Gijs, Jarvis)
#   message: the message text
#   category: link | idea | task | media (optional)
#
# Examples:
#   chat-logger.sh in Gijs "Check deze link: https://example.com" link
#   chat-logger.sh out Jarvis "Link opgeslagen en geanalyseerd"
#   chat-logger.sh in Gijs "Misschien een dashboard bouwen voor stats" idea

set -euo pipefail

JARVIS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DATA_DIR="$JARVIS_ROOT/Data"
CHAT_DIR="$DATA_DIR/chat"
LINKS_FILE="$DATA_DIR/input/links.md"
IDEAS_FILE="$DATA_DIR/input/ideas.md"

# --- Validate args ---
if [ $# -lt 3 ]; then
    echo "Gebruik: $0 <in|out> <user> <message> [link|idea|task|media]"
    exit 1
fi

DIRECTION="$1"
USER="$2"
MESSAGE="$3"
CATEGORY="${4:-}"

if [[ "$DIRECTION" != "in" && "$DIRECTION" != "out" ]]; then
    echo "Fout: direction moet 'in' of 'out' zijn"
    exit 1
fi

# --- Timestamps ---
TODAY=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
CHAT_FILE="$CHAT_DIR/$TODAY.md"

# --- Ensure directories exist ---
mkdir -p "$CHAT_DIR"

# --- Create daily log if it doesn't exist ---
if [ ! -f "$CHAT_FILE" ]; then
    echo "# Chat Log — $TODAY" > "$CHAT_FILE"
    echo "" >> "$CHAT_FILE"
fi

# --- Format the entry ---
if [ "$DIRECTION" = "in" ]; then
    ARROW=">>>"
else
    ARROW="<<<"
fi

# Build the log entry
ENTRY="## $TIME
**$USER:** $MESSAGE"

# Add category tag if present
if [ -n "$CATEGORY" ]; then
    ENTRY="$ENTRY
Categorie: $CATEGORY"
fi

# Add media note if applicable
if [ "$CATEGORY" = "media" ]; then
    ENTRY="$ENTRY
Media: zie Data/media/"
fi

ENTRY="$ENTRY
Status: open
"

# --- Append to daily chat log ---
echo "" >> "$CHAT_FILE"
echo "$ENTRY" >> "$CHAT_FILE"

# --- Handle special categories ---

# Links: append to links.md (date-grouped list format)
if [ "$CATEGORY" = "link" ]; then
    URLS=$(echo "$MESSAGE" | grep -oE 'https?://[^ ]+' || echo "$MESSAGE")
    # Add date header if not already present for today
    if ! grep -q "^## $TODAY" "$LINKS_FILE" 2>/dev/null; then
        echo "" >> "$LINKS_FILE"
        echo "## $TODAY" >> "$LINKS_FILE"
        echo "" >> "$LINKS_FILE"
    fi
    echo "- $URLS — onverwerkt" >> "$LINKS_FILE"
    echo "[chat-logger] Link toegevoegd aan $LINKS_FILE"
fi

# Ideas: append to ideas.md (date-grouped list format)
if [ "$CATEGORY" = "idea" ]; then
    if ! grep -q "^## $TODAY" "$IDEAS_FILE" 2>/dev/null; then
        echo "" >> "$IDEAS_FILE"
        echo "## $TODAY" >> "$IDEAS_FILE"
        echo "" >> "$IDEAS_FILE"
    fi
    echo "- $MESSAGE — open" >> "$IDEAS_FILE"
    echo "[chat-logger] Idee toegevoegd aan $IDEAS_FILE"
fi

echo "[chat-logger] Gelogd: $TIME $USER ($DIRECTION) -> $CHAT_FILE"
