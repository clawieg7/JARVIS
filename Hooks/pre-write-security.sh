#!/usr/bin/env bash
# pre-write-security.sh — PreToolUse hook voor Write/Edit tools
#
# Controleert:
# 1. Of het doelpad binnen Development/ valt
# 2. Of de content geen secrets bevat (API keys, passwords, tokens)
#
# Claude Code verwacht JSON op stdin met tool input.
# Exit 0 = toegestaan, exit 2 = blokkeer met foutmelding (naar stderr).

set -euo pipefail

INPUT="$(cat)"

# Haal het pad op uit de tool input (Write gebruikt "file_path", Edit ook)
FILE_PATH="$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
inp = data.get('tool_input', data)
print(inp.get('file_path', inp.get('path', '')))
" 2>/dev/null || true)"

# Haal de content op (Write gebruikt "content", Edit gebruikt "new_string")
CONTENT="$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
inp = data.get('tool_input', data)
print(inp.get('content', inp.get('new_string', '')))
" 2>/dev/null || true)"

# --- Check 1: Werkgebied ---
# Vault Development/ pad
VAULT_DEV="/Users/jarvis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault/Development"
# Recepten uitzondering (zie capture.md)
VAULT_RECEPTEN="/Users/jarvis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault/Projects/🧠 Kennis"

if [[ -n "$FILE_PATH" ]]; then
    # Normaliseer pad (los symlinks op waar mogelijk)
    REAL_PATH="$(python3 -c "import os; print(os.path.realpath('$FILE_PATH'))" 2>/dev/null || echo "$FILE_PATH")"

    IN_DEV=false
    IN_KENNIS=false

    [[ "$REAL_PATH" == "$VAULT_DEV"* ]] && IN_DEV=true
    [[ "$REAL_PATH" == "$VAULT_RECEPTEN"* ]] && IN_KENNIS=true

    if [[ "$IN_DEV" == false && "$IN_KENNIS" == false ]]; then
        echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [WARN] pre-write-security: pad buiten Development/ geblokkeerd: $FILE_PATH" \
            >> "$HOME/.jarvis/logs/security.log" 2>/dev/null || true
        cat >&2 <<EOF
SECURITY: Schrijven buiten Development/ is niet toegestaan.
Pad: $FILE_PATH

Jarvis schrijft alleen binnen:
  - Development/ in de Obsidian vault
  - Projects/🧠 Kennis/ (alleen kennis-content)

Wil je toch schrijven naar dit pad? Vraag Gijs om expliciete toestemming.
EOF
        exit 2
    fi
fi

# --- Check 2: Secrets in content ---
if [[ -n "$CONTENT" ]]; then
    # Patronen die op secrets wijzen
    SECRET_PATTERNS=(
        # API keys
        'sk-[A-Za-z0-9]{20,}'
        'sk-ant-[A-Za-z0-9\-_]{20,}'
        'AKIA[0-9A-Z]{16}'
        # Generic hoge-entropy tokens
        '[Aa][Pp][Ii][_-]?[Kk][Ee][Yy]\s*[:=]\s*["\x27]?[A-Za-z0-9\-_]{16,}'
        '[Tt][Oo][Kk][Ee][Nn]\s*[:=]\s*["\x27]?[A-Za-z0-9\-_.]{16,}'
        # Passwords in assignments
        '[Pp][Aa][Ss][Ss][Ww][Oo][Rr][Dd]\s*[:=]\s*["\x27][^"\x27\s]{6,}'
        # Private keys
        '-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----'
        # Telegram/Discord bot tokens
        '[0-9]{8,10}:[A-Za-z0-9_\-]{35}'
        # Generic secrets
        '[Ss][Ee][Cc][Rr][Ee][Tt]\s*[:=]\s*["\x27]?[A-Za-z0-9\-_]{8,}'
    )

    for PATTERN in "${SECRET_PATTERNS[@]}"; do
        if echo "$CONTENT" | grep -qE "$PATTERN" 2>/dev/null; then
            echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [WARN] pre-write-security: mogelijke secret gevonden in content voor: $FILE_PATH" \
                >> "$HOME/.jarvis/logs/security.log" 2>/dev/null || true
            cat >&2 <<EOF
SECURITY: Mogelijke secret/credential gedetecteerd in de te schrijven content.
Bestand: $FILE_PATH

Secrets horen in .env bestanden, NOOIT in code of markdown.
Gebruik omgevingsvariabelen of verwijs naar de vault .env.

Als dit een false positive is: bevestig bij Gijs voordat je doorgaat.
EOF
            exit 2
        fi
    done
fi

# Alles ok
exit 0
