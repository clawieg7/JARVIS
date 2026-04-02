#!/bin/bash
# chat-context.sh — Show recent chat context for resuming a conversation
# Usage: chat-context.sh [date] [count]
#   date:  YYYY-MM-DD (default: today)
#   count: number of recent entries to show (default: 20)
#
# Output is formatted for Claude to resume the conversation thread.

set -euo pipefail

JARVIS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DATA_DIR="$JARVIS_ROOT/Data"
CHAT_DIR="$DATA_DIR/chat"
LINKS_FILE="$DATA_DIR/input/links.md"
IDEAS_FILE="$DATA_DIR/input/ideas.md"

TARGET_DATE="${1:-$(date +%Y-%m-%d)}"
COUNT="${2:-20}"
CHAT_FILE="$CHAT_DIR/$TARGET_DATE.md"

echo "============================================"
echo "  CHAT CONTEXT — $TARGET_DATE"
echo "============================================"
echo ""

# --- Recent chat entries ---
if [ -f "$CHAT_FILE" ]; then
    # Count total entries (each starts with ## HH:MM)
    TOTAL=$(grep -c '^## [0-9]' "$CHAT_FILE" 2>/dev/null || echo "0")
    echo "Totaal berichten vandaag: $TOTAL"
    echo ""

    echo "--- Laatste $COUNT berichten ---"
    echo ""

    # Extract last N entries: split on ## timestamps, take the last N
    # Use awk to split on entry headers and collect last N
    awk -v count="$COUNT" '
    /^## [0-9][0-9]:[0-9][0-9]/ {
        if (entry != "") entries[++n] = entry
        entry = $0 "\n"
        next
    }
    { entry = entry $0 "\n" }
    END {
        if (entry != "") entries[++n] = entry
        start = (n - count + 1 > 1) ? n - count + 1 : 1
        for (i = start; i <= n; i++) printf "%s", entries[i]
    }
    ' "$CHAT_FILE"
else
    echo "Geen chat log gevonden voor $TARGET_DATE."
    echo ""

    # Try to find the most recent log
    LATEST=$(ls -1 "$CHAT_DIR"/*.md 2>/dev/null | sort -r | head -1)
    if [ -n "$LATEST" ]; then
        LATEST_DATE=$(basename "$LATEST" .md)
        echo "Meest recente log: $LATEST_DATE"
        echo "Gebruik: $0 $LATEST_DATE"
    else
        echo "Geen chat logs gevonden."
    fi
fi

echo ""

# --- Unresolved items ---
echo "--- Openstaande items ---"
echo ""

OPEN_COUNT=0

# Check today's log for open status
if [ -f "$CHAT_FILE" ]; then
    OPEN_ITEMS=$(grep -B 3 'Status: open' "$CHAT_FILE" 2>/dev/null || true)
    if [ -n "$OPEN_ITEMS" ]; then
        echo "$OPEN_ITEMS"
        OPEN_COUNT=$(echo "$OPEN_ITEMS" | grep -c 'Status: open' || echo "0")
        echo ""
    fi
fi

# Check for unprocessed links
UNPROCESSED_LINKS=$(grep 'onverwerkt' "$LINKS_FILE" 2>/dev/null || true)
if [ -n "$UNPROCESSED_LINKS" ]; then
    LINK_COUNT=$(echo "$UNPROCESSED_LINKS" | wc -l | tr -d ' ')
    echo "Onverwerkte links: $LINK_COUNT"
    echo "$UNPROCESSED_LINKS"
    echo ""
fi

# Check for open ideas
OPEN_IDEAS=$(grep '— open' "$IDEAS_FILE" 2>/dev/null || true)
if [ -n "$OPEN_IDEAS" ]; then
    IDEA_COUNT=$(echo "$OPEN_IDEAS" | wc -l | tr -d ' ')
    echo "Open ideeen: $IDEA_COUNT"
    echo "$OPEN_IDEAS"
    echo ""
fi

if [ "$OPEN_COUNT" -eq 0 ] && [ -z "$UNPROCESSED_LINKS" ] && [ -z "$OPEN_IDEAS" ]; then
    echo "Geen openstaande items."
fi

echo ""

# --- Summary for Claude ---
echo "--- Samenvatting voor sessie ---"
echo ""
echo "Datum: $TARGET_DATE"

if [ -f "$CHAT_FILE" ]; then
    # Last message info
    LAST_TIME=$(grep '^## [0-9]' "$CHAT_FILE" | tail -1 | sed 's/## //')
    LAST_USER=$(grep -A 1 "^## $LAST_TIME" "$CHAT_FILE" | grep '^\*\*' | head -1 | sed 's/\*\*\([^:]*\):.*/\1/')
    echo "Laatste bericht: $LAST_TIME van $LAST_USER"
    echo "Totaal berichten: $TOTAL"
fi

echo "Openstaande items: $OPEN_COUNT"
echo ""
echo "Pak de draad op bij het laatste gesprekspunt."
echo "============================================"
