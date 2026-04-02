# Skill: Strategic Compact

## Doel
Handmatig `/compact` voorstellen op logische momenten in plaats van willekeurige auto-compaction.

## Wanneer gebruiken
- Lange sessies die tegen contextlimiet aanlopen (200K+ tokens)
- Multi-fase taken (onderzoek -> plan -> bouw -> test)
- Wisselen tussen ongerelateerde taken in dezelfde sessie
- Na een grote milestone, voor nieuw werk begint
- Wanneer responses trager worden of minder coherent

## Waarom strategisch compacten?

Auto-compaction triggert op willekeurige momenten:
- Vaak midden in een taak, waardoor belangrijke context verloren gaat
- Geen bewustzijn van logische taakgrenzen
- Kan complexe multi-stap operaties onderbreken

Strategisch compacten op logische grenzen:
- **Na verkenning, voor uitvoering** — compact onderzoekscontext, bewaar implementatieplan
- **Na milestone** — schone start voor volgende fase
- **Voor contextwissel** — maak exploratie context vrij voor andere taak

## Beslissingskader

| Fase-overgang | Compacten? | Reden |
|---|---|---|
| Onderzoek -> Planning | Ja | Onderzoekscontext is groot; plan is het gedistilleerde resultaat |
| Planning -> Implementatie | Ja | Plan staat in bestanden; maak context vrij voor code |
| Implementatie -> Testen | Misschien | Bewaar als tests recente code refereren; compact bij focuswissel |
| Debugging -> Volgende feature | Ja | Debug traces vervuilen context voor ongerelateerd werk |
| Midden in implementatie | Nee | Variabelnamen, bestandspaden en deelstaat verliezen is duur |
| Na mislukte aanpak | Ja | Maak dead-end redenering vrij voor nieuwe poging |

## Wat overleeft compaction

| Overleeft | Verloren |
|---|---|
| CLAUDE.md instructies | Tussentijdse redenering en analyse |
| Takenlijsten in bestanden | Bestandsinhoud die je eerder las |
| Memory bestanden | Multi-stap conversatiecontext |
| Git state (commits, branches) | Tool call historie |
| Bestanden op schijf | Nuances die Gijs mondeling noemde |

## Best practices

1. **Compact na planning** — zodra plan klaar is in bestanden, compact voor verse start
2. **Compact na debugging** — maak foutoplossingscontext vrij voor vervolg
3. **Niet compacten midden in implementatie** — bewaar context voor gerelateerde wijzigingen
4. **Schrijf voor je compact** — sla belangrijke context op in bestanden of Memory/ voor compaction
5. **Gebruik `/compact` met samenvatting** — voeg focus toe: `/compact Focus op auth middleware implementatie`

## Token-optimalisatie

### Context bewust laden
- **CLAUDE.md** — altijd geladen, houd lean
- **Skills** — elke skill voegt 1-5K tokens toe, laad alleen wat nodig is
- **Conversatiegeschiedenis** — groeit per uitwisseling
- **Tool resultaten** — file reads, zoekresultaten nemen ruimte

### Duplicatie voorkomen
- Dezelfde regels in zowel `~/.claude/rules/` als project `.claude/rules/` vermijden
- Skills die CLAUDE.md instructies herhalen identificeren en opschonen
- Overlappende skills consolideren

## Chaining
- Voor deze skill -> elke langlopende taak
- Na deze skill -> verse start met focus op volgende fase

## Afhankelijkheden
- Claude Code `/compact` commando
