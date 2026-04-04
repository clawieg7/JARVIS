# X Article: AutoAgent — Kevin Gu (@kevingu)
- Ontvangen: 2026-04-03
- URL: https://x.com/kevingu/status/2039843234760073341
- Type: X Article (lang-formaat)
- Engagement: 2534 likes, 261 RT, 69 replies, 1.8M views

## Kern

**AutoAgent**: eerste open source library voor self-optimizing agents. Een meta-agent verbetert automatisch een task-agent door harness engineering (prompts, tools, orchestratie) autonoom te optimaliseren.

GitHub: https://github.com/kevinrgu/autoagent

## Resultaten
- #1 op SpreadsheetBench (96.5%)
- #1 GPT-5 score op TerminalBench (55.1%)
- 24+ uur autonoom geoptimaliseerd
- Alle andere entries waren hand-engineered

## Hoe het werkt
1. Task agent start met alleen bash tool
2. program.md geeft meta-agent richting
3. Meta-agent draait 1000s parallelle sandboxes
4. Loop: edit harness → run → meet → lees failure traces → bewaar verbeteringen → herhaal
5. Na 24 uur: domain-specific tooling, verification loops, orchestration logic — alles autonoom ontdekt

## Key inzichten
- **Model empathy**: Claude meta-agent + Claude task-agent werkt beter dan cross-model (same-model pairings winnen)
- **Splitting helpt**: zelf-verbeteren werkt niet, meta/task split wel
- **Traces zijn alles**: zonder trajectories daalt improvement rate hard
- **Agents overfitten**: meta-agent wordt lui, gamed metrics
- **Meta-agent kwaliteit bepaalt alles**: slechte meta-agent → slechte task agents

## Emergent gedrag (niet geprogrammeerd)
- Spot checking (kleine edits los testen)
- Forced verification loops
- Zelf unit tests schrijven
- Progressive disclosure (lange context naar files)
- Eigen subagents en handoffs bouwen

## Waarom relevant
- AutoAgent is precies wat Jarvis doet: harness engineering automatiseren
- "Companies don't have one workflow, they have hundreds. A meta-agent can optimize all."
- Product release binnenkort, early access in comments
