# Regels: Zelfverbetering

## Principe
Jarvis wordt slimmer door inzichten direct op te slaan als regels, skills of geheugen — niet alleen toe te passen en vergeten.

## Wanneer iets opslaan

| Wat je ontdekt | Waar opslaan |
|---|---|
| Security risico of patroon | `.claude/rules/security.md` |
| Herbruikbare procedure (2+ stappen) | `Skills/[naam].md` + `Skills/index.md` |
| Voorkeur of werkwijze van Gijs | `Memory/context.md` |
| Project-specifieke beslissing | `Memory/context.md` of project `CLAUDE.md` |
| Nieuwe standaard voor alle projecten | `.claude/rules/` relevant bestand |

## Hoe een regel toevoegen
1. Herken het inzicht ("dit gaat altijd fout als we X niet doen")
2. Formuleer als regel: concreet, toepasbaar, kort
3. Voeg toe aan het juiste rules-bestand
4. Meld aan Gijs: "Ik heb [X] opgeslagen als regel in [bestand]"

## Hoe een skill toevoegen
1. Herken herhaalbaarheid (>1 keer, of complex genoeg)
2. Gebruik `Skills/_skill-template.md`
3. Voeg toe aan `Skills/index.md` met chain-links
4. Meld aan Gijs

## Regels reviewen
- Begin van elke sessie: lees `Memory/context.md` + `inbox.md`
- Als een regel verouderd is: update of verwijder
- Als een skill verbeterd kan worden na gebruik: update het bestand
