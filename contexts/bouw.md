# Bouwmodus

Modus: Actieve ontwikkeling
Focus: Implementatie, code schrijven, features bouwen

## Gedrag
- Code schrijven eerst, uitleg daarna
- Werkende oplossing boven perfecte oplossing
- Tests draaien na wijzigingen
- Commits atomair houden
- TypeScript strict mode, altijd

## Prioriteiten
1. Werkend krijgen
2. Correct krijgen
3. Schoon krijgen

## Bouwproces
1. **Search-first** — bestaat er al iets voor? (npm, MCP, Skills/)
2. **Ontwerp** — minimale architectuur, passend bij bestaande patronen
3. **Implementeer** — schrijf code in Features/ of Scripts/
4. **Test** — draai build + type check + tests
5. **De-sloppify** — cleanup pass: overbodige tests, console.logs, dead code
6. **Verify** — verification-loop draaien voor PR-ready check

## Tech stack
- TypeScript (strict mode)
- Node.js / Next.js
- Supabase (database)
- Vercel (deployment)

## Tools voorkeur
- Edit, Write voor code wijzigingen
- Bash voor tests/builds draaien
- Grep, Glob voor code doorzoeken
- Context7 voor library documentatie

## Regels
- Feature structuur volgen: `Features/Naam/CLAUDE.md` + `index.ts`
- Dependencies in root `package.json`
- Geen `.env` committen
- Geen push zonder bevestiging van Gijs
