#!/bin/bash
# Sync alle to-dos naar 🎯 To do's - ALL.md in vault root
# Opbouw: Things (deep/bussy/inbox) → Google → Obsidian → Andere
# Read-only spiegel

VAULT="/Users/jarvis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian vault"
OUTPUT="$VAULT/🎯 To do's - ALL.md"
THINGS_DB="$HOME/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite"
PROJECTS_DIR="$VAULT/Development/Projects"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

# Helper: render area with projects and tasks
render_area() {
  local area="$1"
  local area_escaped=$(echo "$area" | sed "s/'/''/g")

  local count=$(sqlite3 "$THINGS_DB" "
    SELECT COUNT(*)
    FROM TMTask t
    LEFT JOIN TMTask p ON t.project = p.uuid AND p.type = 1
    LEFT JOIN TMArea a ON COALESCE(t.area, p.area) = a.uuid
    WHERE t.status = 0 AND t.type = 0 AND t.trashed = 0 AND a.title = '$area_escaped'
  " 2>/dev/null)

  [ "$count" -eq 0 ] 2>/dev/null && return

  echo "### $area ($count)" >> "$OUTPUT"
  echo "" >> "$OUTPUT"

  sqlite3 "$THINGS_DB" "
    SELECT DISTINCT COALESCE(p.title, '(los)') as proj,
    (SELECT COUNT(*) FROM TMTask t2
     LEFT JOIN TMTask p2 ON t2.project = p2.uuid AND p2.type = 1
     LEFT JOIN TMArea a2 ON COALESCE(t2.area, p2.area) = a2.uuid
     WHERE t2.status = 0 AND t2.type = 0 AND t2.trashed = 0
       AND a2.title = '$area_escaped'
       AND COALESCE(p2.title, '(los)') = COALESCE(p.title, '(los)')
    ) as cnt
    FROM TMTask t
    LEFT JOIN TMTask p ON t.project = p.uuid AND p.type = 1
    LEFT JOIN TMArea a ON COALESCE(t.area, p.area) = a.uuid
    WHERE t.status = 0 AND t.type = 0 AND t.trashed = 0 AND a.title = '$area_escaped'
    GROUP BY 1
    ORDER BY cnt DESC
  " 2>/dev/null | while IFS='|' read -r project cnt; do
    if [ "$project" != "(los)" ]; then
      echo "**$project** ($cnt)" >> "$OUTPUT"
    else
      echo "**Losse taken** ($cnt)" >> "$OUTPUT"
    fi

    local proj_escaped=$(echo "$project" | sed "s/'/''/g")
    local proj_filter
    if [ "$project" = "(los)" ]; then
      proj_filter="p.uuid IS NULL"
    else
      proj_filter="p.title = '$proj_escaped'"
    fi

    sqlite3 "$THINGS_DB" "
      SELECT '- [ ] ' || t.title ||
        CASE WHEN t.deadline IS NOT NULL THEN ' ⚠️' || printf('%02d/%02d', (t.deadline >> 12) & 0xF, (t.deadline >> 7) & 0x1F) ELSE '' END
      FROM TMTask t
      LEFT JOIN TMTask p ON t.project = p.uuid AND p.type = 1
      LEFT JOIN TMArea a ON COALESCE(t.area, p.area) = a.uuid
      WHERE t.status = 0 AND t.type = 0 AND t.trashed = 0
        AND a.title = '$area_escaped' AND $proj_filter
      ORDER BY t.todayIndex
      LIMIT 15
    " 2>/dev/null >> "$OUTPUT"

    local remaining=$((cnt - 15))
    if [ "$remaining" -gt 0 ] 2>/dev/null; then
      echo "- *... +${remaining} meer*" >> "$OUTPUT"
    fi
    echo "" >> "$OUTPUT"
  done
}

# --- HEADER ---
cat > "$OUTPUT" << HEADER
# 🎯 To do's — ALL

> **Read-only spiegel.** Afvinken hier heeft geen effect. Werk in de bron.
> Laatst gesynchroniseerd: $TIMESTAMP

HEADER

# ============================================================
# THINGS 3
# ============================================================
things_total=$(sqlite3 "$THINGS_DB" "SELECT COUNT(*) FROM TMTask WHERE status = 0 AND type = 0 AND trashed = 0" 2>/dev/null)

cat >> "$OUTPUT" << EOF
---

# Things 3 ($things_total)

EOF

# --- DEEP ---
cat >> "$OUTPUT" << 'EOF'
## 🔵 Deep

> Taken met directe impact op doelen. Fundamenteel, dichter bij je doel.

EOF

DEEP_AREAS=("🧠 Deep" "🎯 Doelen" "💰 Wealthset " "🧘🏼‍♂️ Mindset " "💪🏼 Healthset" "Claude area" "Web development")
for area in "${DEEP_AREAS[@]}"; do
  render_area "$area"
done

# --- BUSSY ---
cat >> "$OUTPUT" << 'EOF'
## 🟡 Bussy

> Taken die ook moeten maar niet direct bijdragen. Secundair, administratief.

EOF

BUSSY_AREAS=("🌀 Bussy" "❤️ Heartset " "🗣️ Relationships" "🧭 Reizen ")
for area in "${BUSSY_AREAS[@]}"; do
  render_area "$area"
done

# --- THINGS INBOX ---
inbox_count=$(sqlite3 "$THINGS_DB" "
  SELECT COUNT(*)
  FROM TMTask t
  WHERE t.status = 0 AND t.type = 0 AND t.trashed = 0
    AND t.area IS NULL AND t.project IS NULL
" 2>/dev/null)

cat >> "$OUTPUT" << EOF
## 📥 Inbox ($inbox_count)

> Ongesorteerde taken — nog toewijzen aan area/project

EOF

sqlite3 "$THINGS_DB" "
  SELECT '- [ ] ' || t.title
  FROM TMTask t
  WHERE t.status = 0 AND t.type = 0 AND t.trashed = 0
    AND t.area IS NULL AND t.project IS NULL
  ORDER BY t.creationDate DESC
  LIMIT 25
" 2>/dev/null >> "$OUTPUT"

remaining=$((inbox_count - 25))
if [ "$remaining" -gt 0 ] 2>/dev/null; then
  echo "- *... +${remaining} meer*" >> "$OUTPUT"
fi
echo "" >> "$OUTPUT"

# ============================================================
# GOOGLE
# ============================================================
cat >> "$OUTPUT" << 'EOF'
---

# Google

> Calendar events en Gmail acties.
> Sync via MCP bij volgende sessie met MCP toegang.

*Wordt automatisch aangevuld.*

EOF

# ============================================================
# OBSIDIAN
# ============================================================
cat >> "$OUTPUT" << 'EOF'
---

# Obsidian Development Projecten

EOF

for status_dir in "In progress" "Backlog"; do
  for inbox in "$PROJECTS_DIR/$status_dir"/*/inbox.md; do
    [ -f "$inbox" ] || continue
    project=$(basename "$(dirname "$inbox")")
    label="$project"
    [ "$status_dir" = "Backlog" ] && label="$project (backlog)"

    open_tasks=$(grep -E '^\s*- \[[ !]\]' "$inbox" 2>/dev/null)
    count=$(echo "$open_tasks" | grep -c '\S' 2>/dev/null)

    if [ "$count" -gt 0 ]; then
      echo "## $label ($count)" >> "$OUTPUT"
      echo "" >> "$OUTPUT"
      echo "$open_tasks" >> "$OUTPUT"
      echo "" >> "$OUTPUT"
    fi
  done
done

# ============================================================
# ANDERE
# ============================================================
cat >> "$OUTPUT" << 'EOF'
---

# Andere bronnen

> Todoist imports, email acties, losse notities.

## Handgeschreven notities (2026-04-03)

> Bron: foto notitieboek. Nog toevoegen aan Things.

- [ ] Mail Marlies
- [ ] Magnums + croissantje (vrijdag)
- [ ] Wandkleed ophangen
- [ ] Rem auto (woe volgende week)
- [ ] Kelder opruimen + kaart (woe volgende week)
- [ ] Zolder herindelen
- [ ] Glas repareren (blauw licht)
- [ ] Badkamer kaart repareren
- [ ] Hout hakken
- [ ] Banden wissel
- [ ] Lijm huisje Marokko
- [ ] 2x rekje keuken
- [ ] Nieuwe porto
- [ ] Eettafel lamp
- [ ] Gaas/kelder check
- [ ] Sleutel kastje verplaatsen
- [ ] Hal schilderen
- [ ] Kastje hal + spiegel
- [ ] Foto's

EOF

# --- FOOTER ---
obsidian_total=$(grep -rch '^\s*- \[[ !]\]' "$PROJECTS_DIR"/*/inbox.md "$PROJECTS_DIR"/*/*/inbox.md 2>/dev/null | paste -sd+ - | bc 2>/dev/null || echo "?")

cat >> "$OUTPUT" << EOF
---

> **Totaal: ${things_total} Things + ${obsidian_total} Obsidian = $((things_total + obsidian_total))**
> Script: Jarvis/Scripts/sync-all-todos.sh | Elke 6 uur
EOF

echo "[$(date '+%Y-%m-%d %H:%M')] [INFO] To-do sync voltooid"
