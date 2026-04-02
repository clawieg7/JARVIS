# Chat Analyse — Week 2026-04-01

Periode: 1 april - 3 april 2026
Bron: Claude Code sessie-logs Gijs

---

## Meest besproken onderwerpen

| # | Onderwerp | Frequentie | Toelichting |
|---|---|---|---|
| 1 | Telegram setup/fix | 30+ vermeldingen | Bot configuratie, reconnects, tmux sessie, native plugin. Grootste tijdsinvestering van de week. |
| 2 | Rules/skills/learning | 20+ vermeldingen | "leer", "sla op als regel", "skill" — Gijs wil dat Jarvis zichzelf continu verbetert en inzichten vastlegt. |
| 3 | Autonomie | 15+ vermeldingen | "werk door", "24/7", "zelfstandig" — verwachting van ononderbroken, zelfstandig werk zonder vragen. |
| 4 | Structuur | 15+ vermeldingen | inbox.md, done.md, projectstructuur — organisatie van taken en werkwijze. |
| 5 | Security | 10+ vermeldingen | .env, permissions, sudo — beveiliging van secrets en systeemtoegang. |
| 6 | MCP/integraties | 10+ vermeldingen | Nieuwe tools aansluiten, testen, documenteren. |

---

## Gemiste taken

Taken die Gijs heeft genoemd maar (waarschijnlijk) niet in een inbox terecht zijn gekomen:

| Taak | Bron | Status |
|---|---|---|
| "scoor buddy 95 op alle domeinen" — scoring systeem voor Jarvis kwaliteit | chat apr 1-3 | Niet geimplementeerd |
| "leer films bij tars en jarvis" — JARVIS/TARS filmonderzoek voor persoonlijkheid | chat apr 1-3 | Niet uitgevoerd |
| "installeer dokker" — Docker installatie op Mac Mini | chat apr 1-3 | Niet uitgevoerd |
| `sudo systemsetup -setremotelogin on` — SSH remote login activeren | chat apr 1-3 | Niet bevestigd |
| "bedenk oplossingen ad hoc voor problemen" — proactieve probleemoplossing als skill | chat apr 1-3 | Niet vastgelegd |
| "ntfy melding 60 sec van tevoren" — pre-notificatie voor agenda events | chat apr 1-3 | Niet geimplementeerd |
| "ecc reference moet op juiste plek" — ECC repo locatie opschonen | chat apr 1-3 | Niet uitgevoerd |
| "onderzoek bestaande links van website en gebruik ter inspiratie" — website research | chat apr 1-3 | Niet uitgevoerd |

---

## Patronen in werkwijze

### Communicatiestijl Gijs
- Korte imperatieven: "doe X", "fix Y", "sla op"
- Verwacht directe uitvoering, geen terugvragen
- Raakt gefrustreerd bij onnodige vragen over zaken die Jarvis zelf moet beslissen
- Wil parallel execution en continuous work

### Verwachtingen
- Jarvis moet zelfstandig prioriteiten stellen
- Updates via Telegram, niet via vragen
- Leren en verbeteren is een kernwaarde, niet optioneel
- Autonomie > perfectie — liever 80% goed en doorwerken dan 100% met blokkade

### Werkritme
- Hoog tempo, veel context switches
- Meerdere projecten tegelijk actief
- Voorkeur voor snelle iteraties boven grote plannen

---

## 3 dingen die goed gingen

1. **Telegram integratie is live** — Ondanks 30+ iteraties is de Telegram bot uiteindelijk werkend opgezet als primair communicatiekanaal. Dit is de basis voor alle autonomie.

2. **Rules en skills framework staat** — Er is een solide structuur neergezet voor zelfverbetering: rules in `.claude/rules/`, skills in `Skills/`, memory in `Memory/`. Dit maakt Jarvis cumulatief slimmer.

3. **Structuur en conventies vastgelegd** — inbox.md/done.md systeem, projectstructuur, security regels, sessie protocol — de fundamenten staan waardoor werk herhaalbaar en traceerbaar is.

---

## 3 dingen die beter kunnen

1. **Taken vallen tussen wal en schip** — 8 taken uit de chat zijn niet in een inbox terechtgekomen. Elke instructie van Gijs moet direct als taak worden vastgelegd, ook als het een terloopse opmerking lijkt.

2. **Te veel tijd aan Telegram debugging** — 30+ vermeldingen wijst op te veel trial-and-error. Bij complexe setup: eerst architectuur uitdenken, dan bouwen. Niet steeds opnieuw beginnen.

3. **Terugvragen waar autonomie verwacht wordt** — Gijs verwacht dat Jarvis zelf beslist bij implementatiekeuzes. Alleen terugvragen bij echte blokkades (permissions, budget, externe accounts), niet bij technische keuzes.

---

## Actiepunten voor volgende week

- [ ] Verwerk alle 8 gemiste taken (zie backlog in inbox.md)
- [ ] Bouw "capture-alles" skill: elke instructie van Gijs direct naar inbox, geen uitzonderingen
- [ ] Docker installeren en configureren op Mac Mini
- [ ] Buddy scoring systeem ontwerpen en implementeren (95/100 target)
- [ ] JARVIS/TARS films bestuderen voor persoonlijkheidskalibratie
- [ ] Pre-notificatie systeem (ntfy 60s voor events) bouwen
- [ ] Telegram stabiliteit monitoren — max 1 reconnect per dag als target
- [ ] Proactieve probleemoplossing skill documenteren en activeren
