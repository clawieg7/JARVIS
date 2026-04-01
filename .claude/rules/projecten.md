# Regels: Projecten

## Standaard structuur elk project
Bij aanmaken of openen van een project in `Development/`:
```
ProjectNaam/
  inbox.md          ← taken & instructies
  CLAUDE.md         ← project-specifieke regels voor Claude
  .gitignore        ← altijd aanwezig (zie security.md)
  .env.example      ← als project env vars gebruikt
  Skills/           ← herbruikbare procedures
  Agents/           ← agent definities
  Scripts/          ← automatiseringsscripts
  Hooks/            ← Claude Code hooks
  Features/         ← feature modules
```

## .gitignore per project
Elk project met eigen git repo krijgt minimaal:
```
.env
node_modules/
dist/
.DS_Store
```

## inbox.md per project
- Elk project heeft een `inbox.md`
- Formaat: `[ ]` open, `[x]` af, `[~]` bezig, `[!]` urgent
- Bij sessiestart: lees inbox van actief project

## CLAUDE.md per project
- Beschrijft doel, architectuur, uitvoercommando's
- Verwijst naar relevante skills en agents
- Wordt geladen bij `cd` naar projectmap

## Bij nieuw project aanmaken
Controleer altijd bovenstaande structuur en maak ontbrekende bestanden aan.
