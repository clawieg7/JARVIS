# Skill: Skill Chaining

## Doel
Skills aan elkaar koppelen tot workflows. Een skill is een atomaire actie; een chain is een reeks skills die samen een groter doel bereiken.

## Kernprincipe: Filesystem = Message Bus
Skills communiceren via bestanden, niet via pipes of shared memory:
- Elke skill schrijft output naar een well-known pad
- Volgende skill leest van dat pad
- Handoff files zijn gestructureerd (vaste secties, niet vrije tekst)

## Data Passing Mechanismen

| Mechanisme | Wanneer | Voorbeeld |
|---|---|---|
| Named handoff files | Tussen chain stages | `Data/handoffs/{skill}-{datum}.md` |
| Feedback files | Iteratieve loops | `Data/feedback/feedback-NNN.md` |
| SHARED_TASK_NOTES.md | Multi-iteratie loops | Accumuleert wat geprobeerd/gelukt/gefaald is |
| inbox.md | Async routing | Actiepunten uit analyses → project inbox |
| Telegram | Gijs-facing output | Eindresultaat, vragen, updates |

## Trigger Types (betrouwbaarheid)

1. **Hooks** (100% betrouwbaar) — PostToolUse, Stop, SessionStart. Vuren automatisch
2. **Cron/LaunchAgent** — Vaste tijden (morning briefing, nightly research)
3. **Slash commands** — User-initiated entry points
4. **DAG auto-dispatch** — Volgende stap valt vrij als dependencies klaar zijn
5. **Completion signal** — Loop stopt als model `TASK_COMPLETE` output geeft

## Chain Patronen

### 1. Sequentieel (simpelste)
```
skill A → handoff file → skill B → handoff file → skill C
```
Elke stap draait als aparte `claude -p` call. Output naar file, input van file.

### 2. Accumulate-then-Batch
```
PostToolUse hook: bij elke Edit/Write → append pad naar temp file
Stop hook: lees alle paden → batch verwerk (lint, format, index)
```
Elimineert per-edit latency. Eén keer verwerken in plaats van N keer.

### 3. Adversarial Feedback Loop (GAN-stijl)
```
Generator → output → Evaluator → score + feedback → Generator (herhaalt)
Exit: score ≥ 7.0 OF max 15 iteraties
Regel: ALTIJD verse reviewer per ronde (anti-anchor bias)
```

### 4. DAG met Auto-Dispatch
```
Missie A (geen deps) → start direct
Missie B (deps: A) → start zodra A klaar
Missie C (deps: A, B) → start zodra A én B klaar
```
Geen orchestrator loop nodig — graaf lost zichzelf op.

### 5. Next-Step Prompting
Elke non-terminal skill eindigt met:
```markdown
## Volgende stap
Run `/skill-naam` of zie `Data/handoffs/current.md`
```
Maakt chain self-documenting. Gebruiker hoeft volgorde niet te onthouden.

### 6. Frontmatter-Declared Chaining
Skills declareren hun chain in YAML frontmatter:
```yaml
---
next-skill: verification-loop
handoff: Data/handoffs/plan.md
---
```
Runtime leest metadata en auto-chaint. Zero code, pure config.
Bron: oh-my-claudecode (23k stars)

### 7. Sentinel-File State Machine
Agents claimen completion door marker files te schrijven:
```
Agent schrijft DONE → Overseer reviewt → schrijft APPROVED of ISSUES.md
APPROVED → merge/volgende stap
ISSUES.md → fix loop (terug naar agent)
```
Filesystem markers vervangen expliciete orchestratie-logica.
Bron: agent-streams

### 8. Risk-Routed Review
Planning fase emit risk metadata:
```json
{"severity": "high", "focus": ["security", "data-loss"]}
```
Review fase leest metadata en selecteert automatisch de juiste reviewer.
High severity → security-reviewer + code-reviewer parallel.
Low severity → alleen code-reviewer.
Bron: AgentMux

### 9. Append-Only Chain Log (progress.md)
Alle skills in een chain appenden naar één `Data/progress.md`:
```markdown
## [07:01] things-sync
Gesyncte taken: 42, conflicts: 0

## [07:02] health-check
Status: OK, uptime: 48h, disk: 67%

## [07:03] morning-briefing
Briefing verstuurd via Telegram
```
Late-chain skills hebben volledige historie zonder alle tussenbestanden te lezen.
Bron: pi-foreground-chains

### 10. Per-Skill Token Budget
Voorkom dat vroege skills context opvreten die latere nodig hebben:
```
scout:   5k tokens  (snel, breed)
planner: 15k tokens (diep, gestructureerd)
worker:  30k tokens (implementatie)
reviewer: 10k tokens (gefocust)
```
Enforce via `MAX_THINKING_TOKENS` of model routing (haiku voor scout, opus voor planner).

## Bestaande Chains

### Morning Briefing
```
cron (07:00) → things-sync → health-check → morning-briefing → Telegram
```

### Daily Report
```
cron (17:00) → things-sync → git-log → daily-report → Telegram
```

### Weekly Review
```
cron (zondag 18:00) → backup-status → things-sync → health-check → weekly-review → Telegram
```

### Bouw Pipeline
```
search-first → implementatie → de-sloppify → verification-loop → commit
```

### Capture Pipeline
```
input → instagram-scraper/x-scraper → capture-alles → inbox-verwerking → project routing
```

### Improvement Loop
```
failure traces → harness-optimizer → regel/skill update → meten → keep/revert
```

### Sync
```
cron 15min → sync-all-todos → 🎯 To do's ALL.md
```

## Model Routing in Chains

| Taak in chain | Model |
|---|---|
| Observatie, logging, scraping | Haiku (goedkoop, snel) |
| Implementatie, code schrijven | Sonnet (beste coding) |
| Planning, architectuur, review | Opus (diepste redenering) |

## Nieuwe Chain Maken

1. Identificeer het doel
2. Splits in atomaire skills (elk doet 1 ding)
3. Bepaal volgorde (data dependencies)
4. Kies trigger type (hook/cron/manual/DAG)
5. Definieer handoff format per stap
6. Voeg `Ketent naar` toe aan elke skill in index.md
7. Implementeer als remote trigger, script, of hook
8. Test elke skill apart, dan de chain

## Regels
- Elke skill moet onafhankelijk werken (los van de chain)
- Output van skill A moet bruikbaar zijn als input voor skill B
- Bij falen: log error + trace, ga door met volgende (graceful degradation)
- Test elke skill apart voordat je de chain test
- Verse reviewers per ronde bij quality gates
- Structured handoff files > vrije tekst (auditeerbaar, resumable)
