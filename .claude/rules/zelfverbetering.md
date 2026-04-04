# Regels: Zelfverbetering

## Principe
Jarvis wordt slimmer door inzichten direct op te slaan als regels, skills of geheugen — niet alleen toe te passen en vergeten.

## Eerst Terugkijken, Dan Oplossen (VERPLICHT)

Bij ELK probleem, VOORDAT je begint:

1. **Check eigen traces** — `Data/traces/*.jsonl`: heb ik dit eerder gehad? Wat was de root cause?
2. **Check optimization log** — `Data/optimization-log.tsv`: heb ik dit al geprobeerd te fixen? Werkte het?
3. **Check bestaande skills/rules** — bestaat er al iets dat dit dekt? Verbeter dat, niet opnieuw bouwen
4. **Check done.md** — heb ik iets vergelijkbaars al opgelost? Hergebruik die aanpak
5. **Check internet** — GitHub, FxTwitter, Context7: hoe lossen anderen dit op? Is er een betere methode?

Pas NA deze checks: los het op. Gebruik wat werkte als startpunt. Vermijd wat niet werkte.

Na oplossing: leg vast wat werkte en wat niet in traces + optimization-log. Verbeter bestaande skills/rules (niet steeds nieuwe maken).

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

## Self-Improvement Loop (uit AutoAgent)

### Bij elke fout: log een failure trace
```
Data/traces/YYYY-MM-DD.jsonl
{"ts":"...","task":"...","expected":"...","actual":"...","root_cause":"...","fix":"...","prevention":"..."}
```

### Wekelijks: harness-optimizer meta-agent draaien
1. Lees traces van afgelopen week
2. Herken patronen (welke fouten komen vaker voor?)
3. Stel gerichte verbeteringen voor (regel/skill/agent)
4. Anti-overfit check: "is dit nog waardevol als deze fout nooit meer voorkomt?"
5. Doorvoeren en meten

### Kernprincipes (bewezen door AutoAgent)
- **Split meta/task**: zelf-verbeteren werkt niet, aparte meta-agent wel
- **Traces > scores**: waarom iets mislukte is belangrijker dan dat het mislukte
- **Model empathy**: schrijf instructies voor hoe Claude redeneert, niet hoe een mens denkt
- **Anti-overfit**: voorkom dat regels te specifiek worden voor één geval
