# AutoAgent Evaluatie — kevinrgu/autoagent

**Datum:** 2026-04-04  
**Repo:** https://github.com/kevinrgu/autoagent  
**Gecloond naar:** `~/projects/autoagent`

---

## Wat is AutoAgent?

AutoAgent is een **meta-agent improvement loop**: een AI-agent (Claude Code of GPT) die autonoom iteraties draait op een agent harness (`agent.py`), de benchmark scoort, en de harness bijwerkt als de score verbetert. Het is vergelijkbaar met autoresearch maar voor agent engineering, niet voor inhoudelijke taken.

De kern: `program.md` stuurt de meta-agent aan. De meta-agent past `agent.py` aan, draait Harbor benchmarks, logt resultaten in `results.tsv`, en herhaalt. Nooit stoppen tenzij de mens ingrijpt.

---

## Structuur

```
agent.py        -- harness under test (editable section + fixed Harbor adapter)
agent-claude.py -- alternatieve harness: Claude SDK variant (identiek patroon)
program.md      -- instructies voor de meta-agent (human-editable directive)
pyproject.toml  -- deps: openai-agents, harbor, pandas, numpy, openpyxl
Dockerfile.base -- base image voor container-isolated task execution
tasks/          -- Harbor benchmark tasks (LEEG in baseline branch)
```

---

## Harbor Adapter: wat doet het?

Harbor is een benchmarking framework dat:
- Tasks uitvoert in Docker containers (volledig geïsoleerd)
- Een `BaseAgent` interface verwacht met `run(instruction, environment, context)`
- Scores van 0.0-1.0 produceert via task-specifieke verifiers (test.sh/test.py)
- ATIF (Agent Trajectory Interchange Format) gebruikt voor trajectory logging

De **fixed adapter boundary** in `agent.py` is de Harbor-Jarvis brug. Dit mag nooit worden aangepast door de meta-agent. De editable sectie bevat: `SYSTEM_PROMPT`, `MODEL`, `MAX_TURNS`, `create_tools()`, `create_agent()`, `run_task()`.

---

## Improvement Loop: hoe werkt het?

```
1. Baseline run → score vaststellen
2. Read run.log + task trajectories
3. Diagnose failures (missende capability, weak prompting, tool gap, etc.)
4. Kies één harness improvement
5. Edit agent.py (alleen editable section)
6. Commit + rebuild + rerun
7. Record in results.tsv (keep/discard op basis van passed count)
8. Herhaal FOREVER
```

Keep/discard regels:
- `passed` omhoog → keep
- `passed` gelijk + harness simpeler → keep
- anders → discard (maar leer er van)

Overfitting protection: elke wijziging moet generiek zijn. "Als deze exacte taak verdwijnt, is deze verbetering nog steeds zinvol?"

---

## Vergelijking: AutoAgent vs Jarvis Harness

| Aspect | AutoAgent | Jarvis |
|--------|-----------|--------|
| **Agent SDK** | `openai-agents` (agent.py) of `claude_agent_sdk` (agent-claude.py) | `claude_agent_sdk` (ECC, Claude Code) |
| **Tools preset** | `run_shell` (minimaal) | `claude_code` preset (volledig) |
| **Model default** | `gpt-5` / `haiku` | Sonnet 4.6 / Haiku 4.5 |
| **Benchmark infra** | Harbor + Docker | Geen (ontbreekt) |
| **Improvement loop** | Geautomatiseerd, score-driven | Handmatig (heartbeat, evolve) |
| **Task format** | Harbor TOML + verifier scripts | Geen standaard |
| **Trajectory logging** | ATIF v1.2/v1.6 JSON | Geen gestructureerd format |
| **Thinking** | Optioneel (THINKING config) | Ingebouwd (extended thinking) |
| **MCP support** | Beperkt (EXTERNAL_MCP_SERVERS dict) | Volledig (alle Jarvis MCP's) |
| **Skills/agents** | Geen (enkelvoudig agent) | 36 agents, 147 skills |
| **Container isolation** | Docker (Harbor) | Geen sandbox per default |

---

## Kan de improvement loop direct op Jarvis draaien?

**Deels, met significant werk.**

### Wat werkt direct

- `agent-claude.py` gebruikt `claude_agent_sdk` — **exact de Jarvis SDK**. De container entrypoint (`_run_in_container`) is drop-in compatible met hoe Jarvis al werkt.
- `program.md` is de meta-agent instructie — dit is gewoon een Claude Code prompt. Jarvis kan dit uitvoeren met `/sprint` of `claude -p "$(cat program.md)"`.
- De editable harness structuur (SYSTEM_PROMPT, tools, orchestration) sluit perfect aan op hoe ECC harnesses configureert.

### Wat Jarvis mist

1. **Harbor benchmark infra** — Harbor is het centrale stuk dat Jarvis compleet mist. Zonder Harbor zijn er geen gestandaardiseerde tasks, geen verifiers, geen scores. Dit is het grootste gat.
2. **Docker task containers** — Harbor draait elke task in een geïsoleerde container. Jarvis heeft geen sandbox per task (wel algemene Docker support).
3. **Task library** — De `tasks/` directory is leeg in de baseline branch. Jarvis zou eigen Harbor-format tasks moeten schrijven om de loop zinvol te maken.
4. **results.tsv experiment log** — Triviaal om toe te voegen, maar ontbreekt in Jarvis.
5. **ATIF trajectory format** — `agent-claude.py` heeft dit al, maar Jarvis logt trajectories niet gestructureerd.

### Wat Jarvis extra heeft (en AutoAgent mist)

- Volledige MCP suite (Telegram, Supabase, Vercel, Gmail, etc.)
- 36 gespecialiseerde agents + 147 skills
- Heartbeat systeem voor continu onderhoud
- Memory systeem (claude-mem)
- `claude_code` tools preset (file edit, bash, search — alles ingebouwd)

---

## Aanbeveling

### Integreer direct

- **`agent-claude.py` als Jarvis harness template** — vervang het standaard `agent.py` patroon in nieuwe experimenten met dit bestand. De Claude SDK integratie en ATIF logging zijn production-ready.
- **`program.md` directive patroon** — gebruik dit als template voor `~/HEARTBEAT.md` iteraties of `evolve` cycles. Het "NEVER STOP" principe + keep/discard rules zijn direct toepasbaar op Jarvis self-improvement loops.
- **Experiment log patroon** — `results.tsv` is een simpele maar effectieve manier om harness iteraties bij te houden. Toevoegen aan `~/Claude/data/harness-experiments.tsv`.

### Bouw zelf (de Harbor dependency is te groot om te skippen als je de loop wil draaien)

- **Minimale Harbor setup** — installeer `harbor` package (`uv add harbor`) en schrijf 3-5 Jarvis-specifieke tasks (bijv. "analyseer en verbeter een heartbeat script", "refactor een Python util", "schrijf tests voor X"). Dit maakt de loop direct bruikbaar.
- **Eigen task verifiers** — Harbor verifiers zijn simpele bash/Python scripts die een score naar `/logs/reward.txt` schrijven. Laagdrempelig.

### Skip

- **Docker container isolation per task** — overkill voor Jarvis. De `claude_code` preset heeft al adequate sandboxing voor de meeste use cases. Gebruik Harbor's `exec()` boundary alleen als je untrusted code gaat runnen.
- **OpenAI variant (`agent.py`)** — Jarvis is Claude-native. De OpenAI variant is niet relevant.

---

## Concrete volgende stappen

1. `uv add harbor` in een Jarvis experiment project
2. Schrijf 5 Harbor tasks die Jarvis self-improvement meten (bijv. heartbeat quality, skill gaps, code review accuracy)
3. Gebruik `agent-claude.py` als harness template
4. Pas `program.md` directive aan voor Jarvis context (vervang "coding agent" → "Jarvis self-improvement agent", verwijder GPT-5 constraint)
5. Draai baseline: `uv run harbor run -p tasks/ --agent-import-path agent:AutoAgent -o jobs`
6. Start de loop

**Tijdsinschatting:** 2-4 uur om Harbor tasks te schrijven + loop te draaien. De harness zelf is klaar.

---

## Bronnen

- Repo: `~/projects/autoagent`
- Harbor docs: https://harborframework.com/docs
- Agent Skills referentie in README: https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering
