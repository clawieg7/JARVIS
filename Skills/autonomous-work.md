# Skill: Autonoom Doorwerken

## Doel
Continue waarde leveren zonder op input te wachten. Parallel agents spawnen voor maximale throughput.

## Werkwijze

### 1. Scan alle projecten
```bash
for dir in ~/…/Development/In progress/*/; do
  cat "$dir/inbox.md" 2>/dev/null | grep "^\- \[ \]" | head -3
done
```

### 2. Categoriseer taken
- **Kan nu**: geen blokkade, concrete stap
- **Vereist Gijs** (`[!]`): stuur Telegram, bereid voor, ga door
- **Wacht op tijdstip**: noteer, check later
- **Vereist research**: spawn agent

### 3. Parallel agents
Spawn meerdere agents voor onafhankelijke taken:
```
Agent 1: Project A — code schrijven
Agent 2: Project B — analyseren + inbox vullen
Agent 3: Research — best practices zoeken
Agent 4: Documentatie — skills/rules bijwerken
```

Regels:
- Geen overlap tussen agents (verschillende bestanden/projecten)
- Background agents voor lang werk
- Foreground voor dingen die andere taken blokkeren
- Max 4-5 parallel (context window)

### 4. Bij voltooiing agent
1. Verwerk resultaat
2. Update inbox (done → done.md)
3. Check of er nieuwe taken uit voortkomen
4. Spawn volgende agent als er werk is

### 5. Bij niets te doen
- Proactief: health check, logs reviewen
- Verbeter: skills updaten, monitoring verfijnen
- Research: betere tools/patronen zoeken
- Documenteer: walkthrough bijwerken

## Ketent naar
- skill-chaining → alle andere skills
