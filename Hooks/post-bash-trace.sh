#!/usr/bin/env bash
# post-bash-trace.sh — PostToolUse hook voor Bash tool
#
# Logt elke uitgevoerde bash command naar ~/.jarvis/logs/bash-trace.log
# Format conform logging.md: [ISO8601] [TYPE] bericht
#
# Claude Code geeft tool input/output via stdin als JSON.

set -euo pipefail

LOG_DIR="$HOME/.jarvis/logs"
LOG_FILE="$LOG_DIR/bash-trace.log"

# Zorg dat de log directory bestaat
mkdir -p "$LOG_DIR"

# Lees JSON input van stdin
INPUT="$(cat)"

# Extraheer het uitgevoerde commando en exit code
COMMAND="$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
inp = data.get('tool_input', data)
print(inp.get('command', '').replace('\n', ' ')[:500])
" 2>/dev/null || echo "(onbekend commando)")"

EXIT_CODE="$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
out = data.get('tool_response', data)
# Claude Code kan exit code doorgeven in output of als veld
print(out.get('exit_code', out.get('exitCode', '?')))
" 2>/dev/null || echo "?")"

TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

# Bepaal log type op basis van exit code
if [[ "$EXIT_CODE" == "0" || "$EXIT_CODE" == "?" ]]; then
    LOG_TYPE="INFO"
else
    LOG_TYPE="WARN"
fi

# Log rotatie: als bestand >10MB, archiveer
if [[ -f "$LOG_FILE" ]]; then
    FILE_SIZE=$(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE" 2>/dev/null || echo 0)
    if [[ "$FILE_SIZE" -gt 10485760 ]]; then
        ARCHIVE="${LOG_FILE%.log}-$(date -u +%Y%m%d%H%M%S).log"
        mv "$LOG_FILE" "$ARCHIVE"
    fi
fi

# Schrijf log entry
echo "[$TIMESTAMP] [$LOG_TYPE] bash exit=$EXIT_CODE cmd=${COMMAND}" >> "$LOG_FILE"

exit 0
