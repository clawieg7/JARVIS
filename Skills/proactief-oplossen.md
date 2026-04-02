# Skill: Proactief Oplossen

## Doel
Ad-hoc problemen herkennen, analyseren en oplossen zonder te wachten op instructies.

## Wanneer gebruiken
- Er treedt een fout op tijdens een taak
- Een service of script werkt niet meer
- Er is een blokkade die Gijs niet zelf kan oplossen
- Health check geeft problemen terug
- Een trigger of LaunchAgent faalt

## Aanpak

### Stap 1: Diagnose eerst
```bash
# Lees de foutmelding volledig — gok niet
# Reproduceer het probleem als mogelijk
# Check logs: launchctl print-disabled, journalctl, stderr
```

### Stap 2: Smallest fix
- Pas het minimale aan om het probleem op te lossen
- Geen refactoring of "verbeteringen" meenemen
- Test daarna direct of het werkt

### Stap 3: Preventie
- Begrijp waarom het probleem kon ontstaan
- Voeg guard of check toe die dit voorkomt
- Documenteer als rule als het patroon herkenbaar is

### Stap 4: Rapporteer
```bash
~/Claude/scripts/notify-telegram.sh "✅ Probleem opgelost: [wat was er fout] → [wat gedaan]"
```
Of bij blokkade:
```bash
~/Claude/scripts/notify-telegram.sh "⚠️ Blokkade: [probleem] — vereist: [wat Gijs moet doen]"
```

## Beslisregels

| Situatie | Actie |
|---|---|
| Fout is duidelijk, fix is veilig | Direct oplossen + rapporteer |
| Fout vereist sudo of destructieve actie | Noteer in inbox met `[!]`, stuur Telegram |
| Fout is onduidelijk | Diagnose verder, max 3 pogingen |
| Service crasht herhaaldelijk | Analyseer root cause, niet alleen herstarten |

## Veelvoorkomende problemen

| Probleem | Snelle check |
|---|---|
| LaunchAgent start niet | `launchctl list | grep jarvis` |
| tmux sessie weg | `tmux ls && tmux new -s jarvis` |
| Telegram bot reageert niet | `ps aux | grep node` |
| Script permission denied | `chmod +x [script]` |
| Node modules missen | `npm install` in project dir |

## Chaining
- Vóór deze skill → [health-check](health-check.md)
- Na deze skill → [incident-response](incident-response.md) (bij ernstige fouten)
- Resultaat → Telegram notificatie

## Afhankelijkheden
- `~/Claude/scripts/notify-telegram.sh`
- Bash toegang tot logs en processen
