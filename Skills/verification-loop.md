# Skill: Verification Loop

## Doel
Uitgebreide kwaliteitsverificatie na code-wijzigingen, voor PR of merge.

## Wanneer gebruiken
- Na het voltooien van een feature of significante code-wijziging
- Voor het aanmaken van een PR
- Na refactoring
- Bij twijfel of alles nog werkt

## Verificatiefases

### Fase 1: Build verificatie
```bash
npm run build 2>&1 | tail -20
```
Bij falen: STOP en fix voordat je verdergaat.

### Fase 2: Type check
```bash
npx tsc --noEmit 2>&1 | head -30
```
Rapporteer alle type errors. Fix kritieke fouten voor je doorgaat.

### Fase 3: Lint check
```bash
npm run lint 2>&1 | head -30
```

### Fase 4: Test suite
```bash
npm run test -- --coverage 2>&1 | tail -50
```
Rapporteer:
- Totaal tests: X
- Geslaagd: X
- Gefaald: X
- Coverage: X%
- Doel: minimaal 80%

### Fase 5: Security scan
```bash
# Check op hardcoded secrets
grep -rn "sk-\|api_key\|password\s*=" --include="*.ts" --include="*.js" . 2>/dev/null | head -10

# Check op console.log in productie code
grep -rn "console.log" --include="*.ts" --include="*.tsx" src/ 2>/dev/null | head -10

# Check .env niet gecommit
git status | grep ".env"
```

### Fase 6: Diff review
```bash
git diff --stat
git diff HEAD~1 --name-only
```
Review elk gewijzigd bestand op:
- Onbedoelde wijzigingen
- Ontbrekende error handling
- Edge cases
- Jarvis-specifiek: schrijft het buiten Development/?

## Output formaat

```
VERIFICATIE RAPPORT
===================

Build:      [PASS/FAIL]
Types:      [PASS/FAIL] (X errors)
Lint:       [PASS/FAIL] (X warnings)
Tests:      [PASS/FAIL] (X/Y geslaagd, Z% coverage)
Security:   [PASS/FAIL] (X issues)
Diff:       [X bestanden gewijzigd]

Totaal:     [KLAAR/NIET KLAAR] voor PR

Te fixen:
1. ...
2. ...
```

## Continu gebruik

Bij lange sessies: draai verificatie na elke grote wijziging:
- Na elke afgeronde functie
- Na elk afgerond component
- Voor je naar de volgende taak gaat

## Chaining
- Voor deze skill -> bouw.md context, implementatie afgerond
- Na deze skill -> git commit of PR aanmaken

## Afhankelijkheden
- npm scripts: `build`, `lint`, `test`
- TypeScript (`tsc`)
- Git
