# Feature Conventies

## Structuur
Elke feature leeft in `Features/Naam/`:
```
Features/
  Telegram/
    CLAUDE.md     ← feature documentatie
    index.ts      ← entrypoint
    claude.ts     ← eventuele submodules
```

## Regels
- Elke feature heeft een eigen `CLAUDE.md` met: doel, architectuur, commando's
- Entrypoint is altijd `index.ts`
- TypeScript, strict mode
- Dependencies in root `package.json`
- Feature-specifieke types in de feature map

## Nieuwe feature toevoegen
1. Maak `Features/Naam/` directory
2. Schrijf `CLAUDE.md` met doel en architectuur
3. Maak `index.ts` entrypoint
4. Voeg npm scripts toe aan root `package.json` indien nodig
5. Test lokaal voordat je integreert
