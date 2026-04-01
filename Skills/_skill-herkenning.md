# Regel: Automatisch skill herkennen

## Wanneer iets een skill wordt
Sla iets op als skill als het aan 2+ criteria voldoet:
- Het is meer dan 1 commando
- Het wordt herhaald of is herhaalbaar
- Het heeft een duidelijke trigger ("als X, dan Y")
- Het kan geketend worden met andere acties
- Het heeft afhankelijkheden die gecontroleerd moeten worden

## Wat GEEN skill is
- Eenmalige fixes
- Project-specifieke code
- Iets wat al in documentatie staat

## Skill aanmaken werkwijze
1. Herken het patroon tijdens werk
2. Maak `Skills/[naam].md` aan via template
3. Voeg toe aan `Skills/index.md`
4. Link naar gerelateerde skills onder "Chaining"

## Skill chainen
Skills kunnen elkaar aanroepen of opvolgen:
```
tailscale-connect → ssh-setup → claude-remote → file-watcher
```
Documenteer dit altijd in het "Chaining" blok van elke skill.

## Standaardisatie
- Bestandsnaam: kebab-case, beschrijvend
- Altijd: Doel, Wanneer, Commando's, Chaining, Afhankelijkheden
- Review skills na gebruik — verbeter ze als je iets nieuws leert
