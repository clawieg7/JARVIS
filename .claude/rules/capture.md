# Regels: Capture Alles

Elke instructie van Gijs wordt gevangen. Niets valt weg.

## Kernregels
1. Elke instructie = inbox entry. Altijd.
2. Elke link = `Data/input/links.md`. Altijd.
3. Elke idee = `Data/input/ideas.md`. Altijd.
4. Elke ruwe input (screenshots, afbeeldingen, gekopieerde tekst) = `Data/input/raw/`. Altijd.
5. Niets gaat verloren. Bij twijfel: capture.
6. Eén bericht kan meerdere captures bevatten — vang ze allemaal.
7. Capture VOOR uitvoering — zodat het traceerbaar is als executie faalt.
8. Originele input is de bron van waarheid — bewaar ALTIJD, ook als je het al verwerkt hebt.

## Herkenning
- Imperatieven: "doe", "fix", "zet op", "installeer", "leer"
- Condities: "zorg dat", "altijd", "nooit"
- Links: elke URL
- Ideeën: "misschien", "zou mooi zijn", "bedenk"
- Regels: "leer dit", "onthoud", "sla op als regel"

## Routing
- Past bij bestaand project? → dat project's inbox.md
- Jarvis-specifiek? → Jarvis inbox.md
- Niet duidelijk? → Jarvis inbox.md (liever te veel dan te weinig)

### Kennis routing (Obsidian vault root)
Content met kenniswaarde hoort in `Projects/🧠 Kennis/`:
- **Recepten** → `Projects/🧠 Kennis/👨🏻‍🍳 Recepten/[categorie]/`
  - Categorieën: Pasta, Curry, Soep, Stoofpot, Rijst & Noodles, Salade, Brood & Deeg, Taart & Dessert, Snacks, Overig
  - Zonder foto's: `[categorie]/Naam.md`
  - Met foto's: `[categorie]/Naam/recept.md` + foto's in dezelfde map
- Andere kenniscategorieën → check bestaande mappen in `Projects/🧠 Kennis/`
- Dit is BUITEN Development/ — schrijven mag hier alleen voor kennis-content

### Recept format (verplicht, GEEN tabellen)
Volgorde: Bron → Eigenschappen → Benodigdheden → Bereidingswijze
```markdown
---
type: recept
tags:
  - bakken
  - dessert
bron: [directe post URL]
personen: [aantal]
tijd: [X min actief + Y wachttijd]
moeilijkheid: [makkelijk/gemiddeld/moeilijk]
updated: [datum]
---
# [emoji] [Naam]
> [one-liner beschrijving]
![[foto.jpg]]

## Bron
[@account](directe-post-URL) — datum

## Eigenschappen
- ⏱ [tijd actief + wachttijd]
- 👥 [personen]
- 🎯 [moeilijkheid]
- 🍽 [keukengerei: pannen, vormen, etc.]

## Benodigdheden
### [Onderdeel]
- 250g bloem
- 2 eieren
- snuf zout

## Bereidingswijze
### Stap 1 — [naam] ([tijd])
1. ...

## Tips
- ...
```

**Regels:**
- Zoek het volledige recept op (bron, internet) — niet alleen de link opslaan
- Ingrediënten als tabel (scanbaar), gegroepeerd per onderdeel
- Bereiding per stap met tijden erbij
- Foto's kopiëren naar Recepten map + embedden
- Benodigdheden vermelden (springvorm, mixer, etc.)
- Moeilijkheidsgraad + totale tijd inschatten
- Bron onderaan (niet bovenaan — ruis als je kookt)
- **Altijd directe link naar de post bewaren** (niet alleen profiel-URL). Bij Instagram: de /p/ of /reel/ URL. Bewaar deze EERST, voordat je begint met verwerken

### Things routing (naast Obsidian)
Taken/actiepunten ook in de juiste Things area/project:
- Recepten, eten, koken → Things 🥘 Koken + Obsidian 🧠 Kennis/👨🏻‍🍳 Recepten
- Boeken → Things 📖 Lezen
- Hiken, wandelen → Things 🥾 Hiken
- Reizen → Things 🧭 Reizen
- Huis, klussen, meubels → Things 🏗️🏡 Verbouwing / huis
- Trading, investeren → Things 💎 10x account
- Sport, gezondheid → Things 💪🏼 Healthset
- Niet alleen in Jarvis Data/input/ dumpen — routeer naar de bron waar Gijs het verwacht
