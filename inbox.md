Jarvis fundament rebuild — autonoom uitvoeren, stap voor stap, debug tot het werkt.

## Formaat
- `[ ]` open
- `[x]` afgerond
- `[~]` in uitvoering
- `[!]` urgent (vereist Gijs)

---

## Fase 0: Blokkades (vereist Gijs op Mac)

- [!] Sudo rechten instellen — eenmalig op Mac terminal:
  ```
  sudo bash -c 'echo "jarvis ALL=(ALL) NOPASSWD: /usr/bin/pmset, /usr/bin/caffeinate, /usr/sbin/softwareupdate, /usr/bin/killall, /bin/launchctl" > /etc/sudoers.d/jarvis && chmod 440 /etc/sudoers.d/jarvis'
  ```
- [!] Sleep permanent uit — eenmalig op Mac terminal:
  ```
  sudo pmset -c displaysleep 5 sleep 0 autorestart 1
  ```
- [!] Full Disk Access voor Terminal — System Preferences > Security > Privacy

---

## Fase 1: Fundament waterdicht

### 1.1 Remote Control fixen
- [x] Fix remote control LaunchAgent — via tmux, --remote-control flag
- [x] Test: claude-rc tmux sessie actief, remote control listening
- [x] Verifieer logs in ~/Claude/logs/remote-control.log

### 1.2 Telegram stabiliseren
- [x] Native plugin draait 22+ uur stabiel
- [x] Voeg NetworkState: true toe aan telegram LaunchAgent plist
- [x] Test end-to-end: Telegram → Claude → antwoord werkt
- [ ] Verwijder TypeScript bot volledig (custom bot code opruimen)

### 1.3 Monitoring
- [x] Watchdog script: ~/Claude/scripts/watchdog.sh — herstart jarvis als down, alert via Telegram
- [x] Health-check script: ~/Claude/scripts/health-check.sh — alle services, 0 problemen
- [x] Watchdog scheduled elke 30 min via cron
- [x] Log rotatie ingebouwd in watchdog (>10MB)

### 1.4 Backup verificatie
- [ ] Test vault-backup.sh handmatig, verifieer git push
- [ ] Test projects-backup.sh, check alle projecten
- [ ] Voeg Jarvis toe aan projects-backup als ontbreekt

---

## Fase 2: Brein — CLAUDE.md + Rules + Skills

### 2.1 CLAUDE.md lean herschrijven
- [ ] Herschrijf: max 150 instructies, alleen essentieel gedrag
- [ ] Verwijder referenties naar niet-bestaande files
- [ ] Voeg morning checklist toe

### 2.2 Ontbrekende rule files
- [ ] identiteit.md — toon, persoonlijkheid JARVIS/TARS
- [ ] session.md — sessie start/einde protocol
- [ ] mcp-tools.md — beschikbare tools en wanneer gebruiken
- [ ] features.md — feature conventies

### 2.3 Skills bouwen
- [ ] things-sync.md — SQLite query, taken ophalen
- [ ] health-check.md — alle services verifiëren
- [ ] morning-briefing.md — weer + agenda + taken + mail
- [ ] backup-status.md — alle backups checken
- [ ] skill-chaining.md — skill: hoe skills aan elkaar koppelen
- [ ] Update Skills/index.md

### 2.4 Memory onderhoud
- [ ] Audit alle memory bestanden op relevantie
- [ ] Verifieer MEMORY.md index = bestanden
- [ ] Voeg architectuur memory toe

---

## Fase 3: Dagelijkse Automatisering

### 3.1 Morning Briefing++
- [ ] Things sync via SQLite toevoegen aan trigger
- [ ] Stale taak detectie (>7 dagen in Today)
- [ ] Tijdschatting per taak
- [ ] Overplanning waarschuwing (>5 taken)
- [ ] Test handmatig via RemoteTrigger run

### 3.2 Mail triage
- [ ] Enable mail processor trigger of integreer in morning briefing
- [ ] Test met echte inbox
- [ ] Classificatie regels bijstellen

### 3.3 Daily report++
- [ ] Voeg Things completed taken toe
- [ ] Voeg git diff samenvatting toe
- [ ] Test handmatig

---

## Fase 4: Secretaris

### 4.1 Planning
- [ ] Agenda vandaag + morgen via Calendar MCP
- [ ] Weekplanning zondag (overzicht komende week)
- [ ] Things deadlines → calendar events sync

### 4.2 Context
- [ ] Weer in morning briefing (wttr.in)
- [ ] Reistijd bij afspraken met locatie

### 4.3 Financieel
- [ ] Budget tracking aanpak definiëren met Gijs
- [ ] Implementeer als bron beschikbaar

---

## Fase 5: Groei

### 5.1 Resilience
- [ ] Secondary notification channel (ntfy.sh backup)
- [ ] Degraded mode definiëren (wat als API down?)
- [ ] Qwen/Ollama lokale fallback onderzoeken

### 5.2 Obsidian als State Layer
- [ ] Obsidian MCP server onderzoeken en installeren
- [ ] Daily note automatisering
- [ ] Tag-based doorzoekbaarheid (#project #waiting #someday)

### 5.3 Monetisatie
- [ ] Walkthrough/Skool class uitwerken
- [ ] Eerste YouTube hook video script
- [ ] Skool community opzetten

### 5.4 Agency
- [ ] Scope definiëren met Gijs
- [ ] Multi-client architectuur ontwerpen

---

## Fase 6: Security

- [ ] chmod 600 alle .env bestanden
- [ ] .gitignore audit: .env overal
- [ ] Check tokens in git history
- [ ] Token rotatie herinnering instellen (kwartaal)
- [ ] MCP server permissions: least privilege
- [ ] Incident response procedure documenteren

---

## Changelog
- 2026-04-02: Volledige rebuild na audit + research best practices
