# Skill: iMessage Backup

## Doel
iMessage als backup communicatiekanaal wanneer Telegram niet bereikbaar is.

## Wanneer gebruiken
- Telegram bot is down of onbereikbaar
- Urgente meldingen die redundantie vereisen (--urgent flag in notify.sh)
- Health check detecteert Telegram storing
- Incident response waarbij alle kanalen worden ingezet

## Commando's / Stappen

### Direct iMessage sturen
```bash
~/.jarvis/scripts/notify-imessage.sh "bericht"
```

### Via unified notify (urgent = alle kanalen)
```bash
~/.jarvis/scripts/notify.sh "bericht" --urgent
```

### Handmatig testen
```bash
~/.jarvis/scripts/notify-imessage.sh "Jarvis iMessage test"
```

## Technische details
- Gebruikt AppleScript via `osascript` om Messages.app aan te sturen
- Apple ID: `clawieg7@gmail.com`
- Vereist: Messages.app actief, iMessage ingelogd op de Mac
- Geen extra dependencies, geen API keys nodig
- Werkt alleen lokaal op de Mac (niet via SSH zonder GUI sessie)

## Kanaal prioriteit
1. **Telegram** — primair, altijd
2. **iMessage** — backup bij Telegram storing, of bij --urgent
3. **ntfy.sh** — extra backup, werkt ook buiten Apple ecosysteem

## Beperkingen
- Vereist actieve GUI sessie (Messages.app moet kunnen draaien)
- Geen ontvangst-bevestiging vanuit script (fire-and-forget)
- Kan geen berichten ontvangen — alleen zenden
- Bij volledige Mac reboot: Messages.app moet opnieuw starten

## Chaining
- Voor deze skill: health-check, incident-response
- Na deze skill: logging (bevestig in logs dat iMessage is verstuurd)

## Afhankelijkheden
- macOS Messages.app met actieve iMessage account
- `osascript` (standaard op macOS)
- Gijs' Apple ID geconfigureerd in script
