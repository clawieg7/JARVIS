# Skill: Search First

## Doel
Altijd eerst zoeken naar bestaande oplossingen voordat je custom code schrijft.

## Wanneer gebruiken
- Bij het starten van een nieuwe feature die waarschijnlijk al bestaat
- Bij het toevoegen van een dependency of integratie
- Voordat je een utility, helper of abstractie schrijft
- Wanneer Gijs zegt "voeg X toe" en je wilt code gaan schrijven

## Workflow

```
1. ANALYSE         — Wat is er nodig? Welke taal/framework constraints?
2. PARALLEL ZOEKEN — npm, MCP servers, Skills/, GitHub, Context7
3. EVALUEREN       — Score kandidaten op functionaliteit, onderhoud, docs, licentie
4. BESLISSEN       — Adopt / Extend / Build
5. IMPLEMENTEREN   — Installeer pakket / configureer MCP / schrijf minimale code
```

## Beslissingsmatrix

| Signaal | Actie |
|---|---|
| Exacte match, goed onderhouden, MIT/Apache | **Adopt** — installeer en gebruik direct |
| Gedeeltelijke match, goede basis | **Extend** — installeer + schrijf dunne wrapper |
| Meerdere zwakke matches | **Compose** — combineer 2-3 kleine packages |
| Niets geschikt gevonden | **Build** — schrijf custom, maar geinformeerd door onderzoek |

## Quick check (voor elke implementatie)

0. **Bestaat dit al in de repo?** -> Grep door relevante modules/tests
1. **Is dit een bekend probleem?** -> Zoek npm/PyPI
2. **Is er een MCP server voor?** -> Check beschikbare MCP tools
3. **Is er een skill voor?** -> Check `Skills/` en `.claude/skills/`
4. **Is er een GitHub implementatie?** -> Zoek naar onderhouden OSS

## Zoekroutes per categorie

### TypeScript/Node.js (Jarvis stack)
- **HTTP clients** -> `ky`, `got`, native `fetch`
- **Validatie** -> `zod` (al in stack)
- **Database** -> Supabase MCP eerst, dan Prisma/Drizzle
- **Testing** -> `vitest`, `jest`
- **Formatting** -> `prettier`, `eslint`

### AI/LLM Integratie
- **Claude SDK** -> Context7 voor laatste docs
- **Prompt management** -> Check MCP servers
- **Document processing** -> `pdfplumber`, `mammoth`

### Telegram (Jarvis primair kanaal)
- **Telegram Bot API** -> `telegraf`, `grammY`, native API
- **Webhooks** -> bestaande feature in `Features/Telegram/`

## Anti-patronen

- **Direct naar code springen** — utility schrijven zonder te checken of het bestaat
- **MCP negeren** — niet checken of een MCP server de capability al biedt
- **Over-wrappen** — library zo zwaar wrappen dat het zijn voordelen verliest
- **Dependency bloat** — enorm pakket installeren voor een klein feature

## Chaining
- Voor deze skill -> onderzoek.md context activeren
- Na deze skill -> bouw.md context, implementatie starten

## Afhankelijkheden
- npm/npx voor package search
- Context7 MCP voor documentatie
- Internettoegang voor GitHub/npm search
