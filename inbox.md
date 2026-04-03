Jarvis — openstaande taken. Done → [[done.md]]

- Hier mogen geen done taken staan
- Elk project heeft eigen inbox.md + done.md
- `[!]` = echte blokkade, niet luiheid

`[ ]` open · `[!]` vereist Gijs

---

## Blokkades

- [!] Calendar permissions: System Settings → Privacy → Calendars → sta Terminal toe
- [!] FileVault uitschakelen voor remote recovery (advies: ja)
- [!] Smart plug voor remote power cycle
- [!] Vercel login: run `npx vercel login` in terminal (browser auth nodig)
- [!] reinrensen.nl: welk Vercel account host de live site? → NIET in clawie-s-projects team. Site draait wel op Vercel (bevestigd). Check vercel.com met andere accounts.

## Open

- [ ] Verifieer mail triage classificatie (na eerste week)
- [ ] Definieer doel per project — elk project concreet doel geven (einddoel, eerste milestone, revenue target, tijd/week, kill criteria). Projecten: Jarvis Agency, FO-Medical, MedCheck, meme hitster, Things sync, gijshegeman.nl, michieluithetbroek.nl, reinrensen.nl
- [ ] Beantwoord 5 Claude profielvragen (15 min, kort en eerlijk)
- [ ] Verwerk 6 onverwerkte Instagram links uit Things Claude area:
  - https://www.instagram.com/p/DWeYdJbDMTe/?img_index=4
  - https://www.instagram.com/reel/DWbMrGjT5sC/
  - https://www.instagram.com/p/DWfA-nqjXgZ/?img_index=1
  - https://www.instagram.com/reel/DWgIAXWDGBm/
  - https://www.instagram.com/reel/DWjAqcLEzoQ/
  - https://www.instagram.com/reel/DWfYGpykVCx/

## Vragen aan Gijs

- [!] FO-Medical: nieuw project aanmaken in Obsidian Development/In progress? (6 taken in Things, geen Obsidian project)
- [!] MedCheck (10 taken) en meme hitster (11 taken): naar In progress verplaatsen of backlog houden?
- [!] Invoice Escalation Bot: hoort bij Jarvis Agency of apart project?
- [!] Rommel-taken in Things Claude area (lege entries, bol.com mail okt 2025, Bulk.com link): mag ik opruimen?
- [!] Handgeschreven to-do's: Things URL scheme werkt niet headless. Wil je ze zelf toevoegen, of mag ik een andere methode proberen?

## Voorstellen Jarvis

> Inzichten uit analyse vandaag → concrete voorstellen. Gijs: akkoord/afwijzen per punt.

### Things opschonen (1521 taken is te veel)
- [ ] **Voorstel: Things inbox triage** — 313 ongesorteerde taken. Jarvis kan categoriseren en voorstel doen per taak welk project/area. Gijs keurt goed. Geschatte besparing: 2 uur handwerk.
- [ ] **Voorstel: Boekenlijst apart project** — ~80+ boektitels staan als losse taken in Things inbox. Verplaatsen naar 1 project "📖 Leeslijst" met prioriteit (nu lezen / later / ooit). Scheelt ~80 taken in inbox.
- [ ] **Voorstel: Dubbele taken mergen** — meerdere duplicaten gevonden (Market Wizards 3x, High Output Management 3x, Man's Search for Meaning 2x, Zero to One 2x). Jarvis kan lijst maken, Gijs keurt merge goed.
- [ ] **Voorstel: EHBO-items bundelen** — 10+ losse EHBO-taken (gaasjes, zwachtels, pincet, etc.) samenvoegen tot 1 checklist-taak onder 🚨 Noodpakket project.

### Productiviteit
- [ ] **Voorstel: Dagelijkse Things briefing** — elke ochtend 07:00 via Telegram: vandaag geplande taken + deadlines deze week + 1 suggestie. Jarvis bouwt dit als trigger.
- [ ] **Voorstel: Google Calendar sync in to-do ALL** — nu staat "wordt aangevuld". Jarvis kan dit bouwen met gcal MCP in het sync script.
- [ ] **Voorstel: Deadline alerts** — 15+ taken met verlopen deadlines (maart 2026). Opruimen of herdateren?

### Projecten
- [ ] **Voorstel: FO-Medical als project** — 6 concrete taken in Things, potentieel revenue. Aanmaken in Development/In progress/ met inbox, CLAUDE.md, skills.
- [ ] **Voorstel: Claude area opschonen** — 62 taken, 30+ horen bij andere projecten (Jarvis infra, Agency, MedCheck). Jarvis routeert, Gijs keurt goed.
- [ ] **Voorstel: Weekly project health check** — elke zondag automatisch: hoeveel taken per project, stale projecten, voortgang. In weekly review integreren.

### Ontbrekende componenten (uit analyse)
- [ ] **Voorstel: 3 ontbrekende skills maken** — ssh-setup.md, daily-report.md, weekly-review.md worden gerefereerd door skill chains maar bestaan niet
- [ ] **Voorstel: Features/Telegram/index.ts bouwen** — CLAUDE.md bestaat, maar implementatie mist. Bot code voor message routing + conversation memory
- [ ] **Voorstel: package.json opzetten** — ESLint, Prettier, test scripts ontbreken (vereist door webdev rules)
- [ ] **Voorstel: Hooks/ directory vullen** — map bestaat maar is leeg. Pre/PostToolUse hooks voor auto-formatting en security checks
- [ ] **Voorstel: Skills/index.md updaten** — 24 skills bestaan maar index is mogelijk niet bijgewerkt met nieuwste (instagram-scraper, sync-all-todos)

## Backlog

- [ ] gijshegeman.nl deployen naar Vercel (na Vercel login)
- [ ] Pre-notificatie 60s voor events (na calendar permissions)
- [ ] Budget tracking Supabase tabel opzetten
