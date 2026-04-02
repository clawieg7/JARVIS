# Skill: Skill Chaining

## Doel
Skills aan elkaar koppelen tot workflows. Een skill is een atomaire actie; een chain is een reeks skills die samen een groter doel bereiken.

## Patroon
```
trigger → skill A → skill B → output
```

Elke skill heeft een `Ketent naar` sectie die aangeeft welke skills erop volgen.

## Bestaande chains

### Morning Briefing Chain
```
cron (07:00) → things-sync → health-check → morning-briefing → Telegram
```

### Daily Report Chain
```
cron (17:00) → things-sync (completed) → git-log → daily-report → Telegram
```

### Weekly Review Chain
```
cron (zondag 18:00) → backup-status → things-sync → health-check → weekly-review → Telegram + rapport
```

## Nieuwe chain maken
1. Identificeer het doel
2. Splits in atomaire skills (elk doet 1 ding)
3. Bepaal de volgorde (data dependencies)
4. Voeg `Ketent naar` toe aan elke skill
5. Documenteer de chain hier
6. Implementeer als remote trigger of script

## Regels
- Elke skill moet onafhankelijk werken (los van de chain)
- Output van skill A moet bruikbaar zijn als input voor skill B
- Bij falen van een skill: log error, ga door met volgende (graceful degradation)
- Test elke skill apart voordat je de chain test
