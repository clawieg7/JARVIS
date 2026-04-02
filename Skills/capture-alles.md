# Skill: Capture Alles

## Doel
Elke instructie, link, idee of opmerking van Gijs wordt gevangen — niets valt tussen wal en schip.

## Wanneer gebruiken
- Bij ELKE interactie met Gijs
- Altijd actief op de achtergrond — dit is geen optionele skill

## Wat telt als instructie

Alles wat een actie, wens of richting impliceert:

| Signaal | Voorbeeld |
|---|---|
| Imperatief | "fix de login", "maak een backup" |
| "Zorg dat..." | "zorg dat de watchdog draait" |
| "Fix / repareer / los op" | "fix die timeout error" |
| "Leer / onderzoek" | "leer hoe MCP servers werken" |
| "Installeer / configureer" | "installeer Docker" |
| "Bouw / maak / schrijf" | "bouw een dashboard" |
| Link gedeeld | URL zonder verdere context |
| Idee / brainstorm | "misschien kunnen we...", "wat als..." |
| Impliciete wens | "die error is irritant" = fix die error |
| Vraag die actie impliceert | "kan Jarvis ook X?" = onderzoek of implementeer X |
| Prioriteitswijziging | "dit moet eerst", "laat X maar" |

**Regel: bij twijfel, capture het.**

## Waar capture je het

### Naar inbox.md (taken, bugs, instructies)

Alles wat een concrete actie vereist:

1. **Projectcontext bekend** → schrijf naar `inbox.md` van dat project
2. **Jarvis-breed** → schrijf naar Jarvis `inbox.md`
3. **Nieuw project** → maak project aan met `inbox.md`, schrijf daar

### Naar Data/input/ (passieve input)

| Type | Bestand | Wanneer |
|---|---|---|
| Link / URL | `Data/input/links.md` | Gijs deelt een link, artikel, tool, repo |
| Idee / brainstorm | `Data/input/ideas.md` | Geen concrete actie, wel bewaren |

**Let op:** een link KAN ook een taak zijn. "Installeer deze tool: [url]" → inbox + links.

## Categorisering

Elke capture krijgt een categorie-tag:

| Categorie | Betekenis | Voorbeeld |
|---|---|---|
| `task` | Concrete actie, af te vinken | "installeer Docker" |
| `bug` | Iets is kapot, moet gefixed | "Telegram crasht bij lange berichten" |
| `rule` | Werkwijze of standaard | "gebruik altijd TypeScript strict mode" |
| `skill` | Herbruikbare procedure | "maak een skill voor deployment" |
| `idea` | Nog geen actie, bewaren | "misschien een dashboard voor uptime" |
| `link` | URL om te verwerken | gedeelde link zonder directe actie |

## Format

### inbox.md entry

```markdown
- [ ] [categorie] Korte beschrijving van de taak
```

Voorbeelden:
```markdown
- [ ] [task] Docker Desktop installeren op Mac Mini
- [ ] [bug] Telegram timeout bij berichten >4096 chars — fix chunking
- [ ] [skill] Deployment skill schrijven voor Vercel projecten
- [ ] [rule] Alle API keys in .env, nooit hardcoded — toevoegen aan security.md
```

### Data/input/links.md entry

```markdown
- [datum] [onderwerp] URL — korte beschrijving / key takeaway
```

Voorbeeld:
```markdown
- [2026-04-01] [MCP] https://github.com/example/mcp-server — nieuwe MCP server voor Notion
```

### Data/input/ideas.md entry

```markdown
- [datum] [domein] Beschrijving van het idee — context waarom relevant
```

Voorbeeld:
```markdown
- [2026-04-01] [monitoring] Uptime dashboard met live status van alle services — past bij health-check skill
```

## Stappen bij elke interactie

```
1. LUISTER  — Lees het bericht van Gijs volledig
2. HERKEN   — Bevat het een instructie, link, idee? (zie signalen hierboven)
3. SORTEER  — Welke categorie? Welk project? inbox of Data/input/?
4. SCHRIJF  — Voeg toe aan het juiste bestand, juiste format
5. BEVESTIG — Meld kort wat je hebt vastgelegd (niet elke keer uitgebreid)
6. GA DOOR  — Voer de instructie ook daadwerkelijk uit als dat kan
```

## Meerdere captures per bericht

Een bericht kan meerdere instructies bevatten. Capture ze ALLEMAAL apart:

> "Fix de login bug, installeer ook Docker, en check die link: https://example.com"

Wordt:
- `inbox.md`: `- [ ] [bug] Login bug fixen`
- `inbox.md`: `- [ ] [task] Docker installeren`
- `Data/input/links.md`: `- [2026-04-01] [onbekend] https://example.com — context bepalen`

## Anti-patronen

- **Vergeten te capturen** — de hele reden dat deze skill bestaat
- **Alleen uitvoeren, niet vastleggen** — als het niet in inbox staat, is het niet traceerbaar
- **Link verwerken maar niet opslaan** — altijd in Data/input/links.md, ook als je het al verwerkt
- **Vaag capturen** — "ding fixen" is nutteloos, schrijf concreet wat en waarom

## Chaining
- Voor deze skill → altijd actief, geen trigger nodig
- Na deze skill → inbox-verwerking (voor prioritering en uitwerking)

## Afhankelijkheden
- Schrijftoegang tot project inbox.md bestanden
- Schrijftoegang tot Data/input/links.md en Data/input/ideas.md
