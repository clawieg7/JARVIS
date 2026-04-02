# Skills Index

Herbruikbare procedures voor Jarvis.

## Meta
- `_skill-template.md` — template voor nieuwe skills
- `_skill-herkenning.md` — wanneer iets een skill wordt
- [skill-chaining](skill-chaining.md) — hoe skills aan elkaar koppelen

## Remote & Connectiviteit
| Skill | Status | Chains naar |
|---|---|---|
| [tailscale-connect](tailscale-connect.md) | Voltooid | ssh-setup |

## Monitoring & Beheer
| Skill | Status | Chains naar |
|---|---|---|
| [health-check](health-check.md) | Voltooid | morning-briefing |
| [backup-status](backup-status.md) | Voltooid | weekly-review |

## Data & Sync
| Skill | Status | Chains naar |
|---|---|---|
| [things-sync](things-sync.md) | Voltooid | morning-briefing, daily-report |

## Dagelijks
| Skill | Status | Chains naar |
|---|---|---|
| [morning-briefing](morning-briefing.md) | Voltooid | Telegram |

## Ontwikkeling & Kwaliteit
| Skill | Status | Chains naar |
|---|---|---|
| [search-first](search-first.md) | Voltooid | bouw.md context |
| [verification-loop](verification-loop.md) | Voltooid | git commit, PR |
| [de-sloppify](de-sloppify.md) | Voltooid | verification-loop |
| [strategic-compact](strategic-compact.md) | Voltooid | elke lange sessie |

## Autonoom werk
| Skill | Status | Chains naar |
|---|---|---|
| [autonomous-work](autonomous-work.md) | Voltooid | — |
| [incident-response](incident-response.md) | Voltooid | Telegram |
| [github-research](github-research.md) | Voltooid | search-first |
| [mcp-management](mcp-management.md) | Voltooid | — |

## Chains
```
Morning:    cron -> things-sync -> health-check -> morning-briefing -> Telegram
Daily:      cron -> things-sync -> git-log -> daily-report -> Telegram
Weekly:     cron -> backup-status -> things-sync -> health-check -> weekly-review -> Telegram

Bouw:       search-first -> implementatie -> de-sloppify -> verification-loop -> commit
Onderzoek:  search-first -> analyse -> samenvatting -> inbox.md
Sessie:     strategic-compact -> na elke fase-overgang
```
