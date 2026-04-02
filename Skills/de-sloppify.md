# Skill: De-Sloppify

## Doel
Aparte cleanup-pass na implementatie om AI-gegenereerde "slop" te verwijderen zonder de implementatie-kwaliteit te beperken.

## Wanneer gebruiken
- Na elke implementatie-stap (feature, bugfix, refactor)
- Wanneer code door een AI agent is gegenereerd
- In elke bouw-pipeline als standaard stap na implementatie
- Bij code review wanneer je typische AI-patronen ziet

## Het probleem

Wanneer je een LLM vraagt om met TDD te implementeren, neemt het "schrijf tests" te letterlijk:
- Tests die TypeScript's type system verifieren (`typeof x === 'string'`)
- Overdreven defensieve runtime checks voor dingen die het type system al garandeert
- Tests voor framework-gedrag in plaats van business logica
- Excessive error handling die de echte code verduistert

## Waarom geen negatieve instructies?

"Test geen type systems" of "voeg geen onnodige checks toe" heeft downstream effecten:
- Het model wordt terughoudend over ALLE tests
- Het slaat legitieme edge case tests over
- Kwaliteit daalt onvoorspelbaar

## De oplossing: aparte pass

Laat de implementatie-agent grondig zijn. Voeg daarna een gefocuste cleanup-agent toe:

```bash
# Stap 1: Implementeer (laat het grondig zijn)
claude -p "Implementeer de feature met volledige TDD. Wees grondig met tests."

# Stap 2: De-sloppify (aparte context, gefocuste cleanup)
claude -p "Review alle wijzigingen in de working tree. Verwijder:
- Tests die taal/framework gedrag verifieren in plaats van business logica
- Redundante type checks die het type system al afdwingt
- Over-defensieve error handling voor onmogelijke states
- console.log statements
- Uitgecommentarieerde code
Bewaar alle business logic tests. Draai de test suite na cleanup."

# Stap 3: Verificeer
claude -p "Draai build + lint + tests. Fix eventuele failures."
```

## Checklist: wat te verwijderen

- [ ] Tests die taal/framework features testen (niet business logica)
- [ ] Redundante type guards die TypeScript al afdwingt
- [ ] `console.log` statements
- [ ] Uitgecommentarieerde code
- [ ] Ongebruikte imports
- [ ] Over-generieke error messages
- [ ] Dubbele null/undefined checks
- [ ] Lege catch blocks
- [ ] TODO comments zonder context

## Checklist: wat te bewaren

- [ ] Business logic tests
- [ ] Edge case tests met echte waarde
- [ ] Error handling voor externe inputs (API, user input)
- [ ] Validatie op security boundaries
- [ ] Logging met structured log levels (niet console.log)

## In een loop context

```bash
for feature in "${features[@]}"; do
  # Implementeer
  claude -p "Implementeer $feature met TDD."

  # De-sloppify
  claude -p "Cleanup pass: review wijzigingen, verwijder slop, draai tests."

  # Verifieer
  claude -p "Draai build + lint + tests. Fix failures."

  # Commit
  claude -p "Commit met message: feat: add $feature"
done
```

## Kernprincipe

> Voeg liever een aparte de-sloppify pass toe dan negatieve instructies. Twee gefocuste agents presteren beter dan een beperkte agent.

## Chaining
- Voor deze skill -> bouw.md context, implementatie afgerond
- Na deze skill -> verification-loop.md

## Afhankelijkheden
- TypeScript compiler (`tsc --noEmit`)
- Test runner (vitest/jest)
- ESLint
