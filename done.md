# Done — Jarvis Project Log

Nieuwste bovenaan, oud onderaan.

---

## 2026-04-05

- 15:45 Inbox cleanup: 4 achterhaalde "ontbrekende componenten" voorstellen naar done (skills bestaan, Telegram via plugin, hooks via ECC)
- 15:45 Vastgoed Beleggingen duplicate verwijderd uit Development/ (stond al correct in Projects/💰Wealthset/)
- 15:30 Telegram bot herstart (dubbele workers opgeruimd)
- 09:13 Rules directory 73% gereduceerd (10 ongebruikte taaldirectories verwijderd, 244KB bespaard)
- 09:00 Podcast organisatie regel geconfigureerd
- 08:44 Home directory cleanup (344MB freed, installers verwijderd)
- 08:20 Podcast-check LaunchAgent gefixt (iCloud → lokaal filesystem)
- 08:19 TMUX_BIN fix + safe-reboot exit code + nightly-autoresearch timeout
- 08:11 Watchdog script variable reference bug gefixt
- 08:03 Claude Code Remote Control omgeving bevestigd werkend
- 07:07 Telegram bot stuck session gekilld + clean herstart

---

## 2026-04-04

- 09:30 Vercel login gelukt (clawieg7-6901), blokkade opgelost
- 09:30 Calendar permissions al OK (auth_value=2), blokkade verwijderd
- 09:25 TCC permissions beheer geleerd: user TCC via sudo sqlite3, system TCC SIP-protected
- 09:25 AppleScript → Things 3 route getest en werkend (CLI-first)
- 09:20 Meme hitster verplaatst van Backlog → In progress
- 09:20 Invoice Escalation Bot → Jarvis Agency inbox
- 09:15 CLI-first feedback opgeslagen + Things 3 workflow vastgelegd
- 09:50 OpenClaw geïnstalleerd + geëvalueerd: multi-channel gateway, Claude API backend OK, aanbeveling gedeeltelijk adopteren
- 09:45 Memory centralisatie plan klaar: ~/.jarvis/memory/ als single source of truth
- 09:40 Heartbeat PATH gefixt: full path naar claude binary + EnvironmentVariables in plist
- 09:10 Jarvis architectuur gap analyse + OpenClaw research afgerond

---

## 2026-04-03

- 00:00 7 skills geïnstalleerd uit alirezarezvani/claude-skills: agent-designer, agent-workflow-designer, saas-metrics-coach, financial-analyst, content-production, launch-strategy, mcp-server-builder
- 23:55 Alle 5 agents afgerond: 6 IG links verwerkt, klopping.nl gescand, Perplexity MCP geëvalueerd (key nodig), claude-skills repo geëvalueerd, 3 skills aangemaakt
- 23:50 6 Instagram links verwerkt: @razvanpbusiness (Claude YouTube $14K/mnd), @leadgenman (5 levels Claude Code), @maxjohnscn (Claude+N8N), @github.awesome (source leak), @rahuljindalai ($5K deal)
- 23:45 klopping.nl volledig gescand: 3 artikelen, 15+ tools gevonden, 5 voorstellen in inbox (Flow, Plaud, Granola, vendor audit, Shortwave)
- 23:40 3 missing skills aangemaakt (ssh-setup, daily-report, weekly-review), Claude area gerouteerd (33→8 projecten), Telegram status verstuurd
- 23:35 Podcast monitor compleet: 3x per dag check (08:00/14:00/20:00), Telegram met topics + key inzichten + fact-check + bronnen + actiepunten, auto deep analyse via claude-rc
- 23:25 Podcast monitor skill + check-podcasts.sh: detecteert nieuwe episodes, analyseert, fact-checkt, stuurt key inzichten via Telegram. Getest en werkend.
- 09:00 Podcast structuur: Data/podcasts/ met All-In + AI Report (Klopping/Wietse), 4 episodes geanalyseerd, klopping.nl als leerbron toegevoegd
- 08:45 "Eerst terugkijken dan oplossen" regel opgeslagen (traces/logs/internet checken voor elk probleem)
- 08:30 Nightly learn loop: LaunchAgent (00:30), research cyclus (GitHub/X/YouTube/HN/arXiv), thought leaders lijst, nightly-learn.sh script
- 08:15 self-optimize.md aangemaakt (program.md equivalent), optimization-log.tsv gestart, CLAUDE.md bijgewerkt
- 08:00 AutoAgent inzichten geïntegreerd: failure trace logging (Data/traces/ + JSONL format), harness-optimizer geüpgraded naar meta-agent, zelfverbetering regel uitgebreid met improvement loop
- 07:50 X/Twitter scraper skill aangemaakt (FxTwitter API, geen login nodig)
- 07:45 Kevin Gu AutoAgent article volledig geanalyseerd en opgeslagen (1.8M views, self-optimizing agents)
- 07:30 Skills/index.md bijgewerkt met 4 nieuwe skills + 3 nieuwe chains (Capture, Improve, Sync)
- 07:25 🎯 To do's ALL.md sync script live (LaunchAgent elke 15 min, Things structuur deep/bussy)
- 07:20 Capture regel uitgebreid: ruwe input altijd bewaren in Data/input/raw/
- 07:15 19 handgeschreven taken gelezen en opgeslagen (Things URL scheme werkt niet headless)
- 07:00 Alle to-dos verzameld: 1521 Things + 79 Obsidian = 1600 taken
- 06:50 Instagram scraper skill 10x verbeterd: betrouwbaarheidsniveaus, verificatiestappen, carousel-waarschuwingen, geleerde lessen
- 06:45 links.md gecorrigeerd: $100 → $50,000 (scrape was fout, screenshots bevestigen juiste bedrag)
- 03:00 Things 3 MCP geïnstalleerd (view/create/complete todos, search, projects)
- 02:50 Playwright MCP geïnstalleerd (headless browser automation, Chromium)
- 02:45 Apple MCP geïnstalleerd (Calendar, Reminders, Notes, Contacts, Mail, Maps)
- 05:10 Website code research: michiel=kwijt, reinrensen=ander Vercel account, Gijs genotificeerd
- 05:05 Docker geïnstalleerd via Colima (geen Desktop GUI nodig, auto-start boot)
- 04:50 Things sync: 77 tests (vitest), alle groen, gecommit
- 04:45 iMessage test naar Gijs verstuurd
- 04:40 iMessage backup kanaal live (notify-imessage.sh, skill, incident-response bijgewerkt)
- 04:30 Dashboard: Data/dashboard.md + update-dashboard.sh (cron elke 6 uur)
- 04:15 GitHub Actions CI/CD workflow aangemaakt (typecheck + secrets scan)
- 04:10 Backup script verbeterd (error handling + Telegram alerts bij failures)
- 04:05 Vercel deploy: geblokkeerd op login (browser auth nodig → inbox)
- 04:00 Memory/context.md volledig bijgewerkt
- 03:55 CHANGELOG.md, .env.example, Hooks/, Data/media/ aangemaakt
- 03:50 Capture-alles skill + rule geschreven
- 03:45 Heartbeat script + uurlijkse cron
- 03:25 SSH remote login geactiveerd (ssh jarvis@100.82.231.116)
- 03:20 Remote Control 24/7 met dedicated script, trust auto-accept, watchdog herstart
- 03:15 Chat analyse week 1: rapport + 8 gemiste taken in backlog
- 03:10 Weekly review trigger: 3 goed + 3 beter + chatanalyse + gemiste taken
- 03:05 Logging regel + herken-regels memory opgeslagen
- 03:00 ~/Claude/ gemerged naar ~/.jarvis/ — één locatie, alle paden bijgewerkt
- 02:40 Obsidian MCP geïnstalleerd (search-vault, read/create/edit notes, tags)
- 02:35 4 MCP install agents + inbox cleanup agent gestart
- 02:30 GitHub research: 40+ repos gevonden, top 5 MCP servers geselecteerd
- 02:20 Daily note LaunchAgent gestopt (schrijft buiten Development/)
- 02:15 Full Disk Access werkt, icalBuddy werkt, calendar syntax gefixt
- 02:10 Chat logging systeem klaar (chat-logger.sh + chat-context.sh)
- 02:05 Alle LaunchAgents geaudit en gefixt (4 fixes)
- 02:00 Alle 6 projecten gecommit
- 01:50 Morning + Daily triggers handmatig gestart
- 01:45 LaunchAgents audit: 4 fixes (HOME var, watcher pad bug, telegram herlaad)
- 01:40 Daily note geverifieerd — werkt, icalBuddy permissions nodig
- 01:35 Alle 6 projecten gecommit
- 01:30 Chat logging systeem: Data/chat, Data/input, Data/media structuur
- 01:25 Formatting regel: nieuw bovenaan, bullets i.p.v. tabellen
- 01:20 bypassPermissions voor telegram + remote control tmux
- 01:00 done.md aangemaakt voor alle 6 projecten
- 00:55 Mac slaapt nooit meer (pmset sleep=0, display=5, autorestart=1)
- 00:50 Sudo NOPASSWD actief
- 00:45 Webdev template + rules (ESLint, SEO, deploy checklist)
- 00:40 ECC integratie: contexts, 4 skills, 4 agents
- 00:25 ECC repo gecloned, workspace audit, security scan
- 00:20 Groei rule + GitHub research + MCP management skills
- 00:10 Security scan: 12 deny rules toegevoegd

---

## 2026-04-02

- 23:50 Website projecten geanalyseerd (3 repos, 49 taken)
- 23:45 Daily notes automatisering (template + script + LaunchAgent 06:30)
- 23:40 ntfy.sh backup channel + uitleg naar Gijs
- 23:30 YouTube hook video script (short + lang versie)
- 23:25 Telegram notificatie naar Gijs voor blokkades
- 23:20 Qwen/Ollama fallback klaar (qwen3.5 + script)
- 23:10 File watcher update (inbox → jarvis tmux, 30s cooldown)
- 23:00 Incident response procedure
- 22:55 Weekly review trigger geüpdatet met weekplanning
- 22:50 MCP permissions audit (least privilege)
- 22:45 Token rotatie herinnering (kwartaal cron)
- 22:40 Legacy TypeScript bot verwijderd
- 22:35 Morning + Daily triggers handmatig getest
- 22:30 Telegram bot geverifieerd
- 22:20 ntfy.sh onderzoek gestart
- 22:00 Security: chmod 600 .env, .gitignore audit, git history clean
- 21:50 Daily report trigger: Things + git + health
- 21:45 Morning briefing trigger: SQLite, stale, tijdschatting, health, mail
- 21:30 Skills: things-sync, health-check, morning-briefing, backup-status, skill-chaining
- 21:15 Rule files: identiteit, session, mcp-tools, features
- 21:10 CLAUDE.md lean herschreven
- 21:05 Backup verificatie: vault + 9 projecten OK
- 21:00 Monitoring: watchdog + health-check + cron + log rotatie
- 20:45 Telegram: NetworkState, stabiel 22+ uur
- 20:30 Remote Control gefixt via tmux
- 20:00 Volledige audit + research + inbox rebuild
- Things sync stability fixes (rate limiter, circuit breaker, backoff, mutex)
- gijshegeman.nl volledig gebouwd (Next.js 14 + Tailwind, 5 pagina's)
- Skool community opzet uitgewerkt (pricing, content, launch plan)
- Things sync inbox herschreven uit Old/ analyse
- Inbox verwerking + project herkenning regels

---

## 2026-04-01

- 23:30 Walkthrough project (17 bestanden, 6 modules)
- 22:00 Telegram plugin live
- 21:00 Telegram LaunchAgent + bot
- 20:00 Remote triggers (morning, daily, weekly)
- 19:00 Backup scripts (vault + projecten)
- 18:00 File watcher + fswatch
- 17:00 Caffeinate LaunchAgent
- 16:00 Tailscale opgezet
