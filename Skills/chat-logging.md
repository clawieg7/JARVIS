# Skill: Chat Logging & Context Recovery

## Doel
Volledige logging van Telegram communicatie zodat de draad altijd opgepakt kan worden. Input van Gijs apart bijhouden: linkjes, foto's, bestanden, ideeën.

## Structuur
```
Jarvis/
  logs/
    chat/
      2026-04-02.md       ← dagelijkse chat log (input + output)
      2026-04-03.md
    input/
      links.md            ← alle gedeelde linkjes met datum
      ideas.md            ← losse ideeën/gedachten
    media/
      2026-04-02-foto1.jpg ← ontvangen foto's/bestanden
```

## Chat log formaat (per dag)
```markdown
# Chat Log — 2026-04-02

## 23:30
**Gijs:** [bericht tekst]
**Jarvis:** [antwoord samenvatting]
Status: afgehandeld / open / doorgestuurd naar [project]

## 23:45  
**Gijs:** [link naar instagram post]
**Jarvis:** [analyse] → doorgestuurd naar [project]/inbox.md
Categorie: link | project: gijshegeman.nl
```

## Links log formaat
```markdown
# Gedeelde Links

| Datum | Link | Analyse | Project | Status |
|-------|------|---------|---------|--------|
| 2026-04-02 | instagram.com/p/... | Product inspiratie | — | onverwerkt |
| 2026-04-01 | github.com/... | MCP server | Jarvis | verwerkt |
```

## Draad oppakken
Bij elke nieuwe sessie of na pauze:
1. Lees laatste chat log: `logs/chat/$(date +%Y-%m-%d).md`
2. Check onafgehandelde items
3. Pak draad op waar gebleven

## Implementatie
De Jarvis tmux sessie moet na elk Telegram bericht:
1. Log input + output naar dagelijkse chat file
2. Als input een link is → ook naar links.md
3. Als input een foto/bestand is → opslaan in media/
4. Als input een idee/taak is → naar juiste project inbox

## Ketent naar
- inbox-verwerking → project-herkenning
