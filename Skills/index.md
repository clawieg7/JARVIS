# Skills Index

Herbruikbare procedures voor Jarvis.

## Meta
- `_skill-template.md` — template voor nieuwe skills
- `_skill-herkenning.md` — wanneer iets een skill wordt
- [skill-chaining](skill-chaining.md) — hoe skills aan elkaar koppelen

## Remote & Connectiviteit
| Skill | Status | Chains naar |
|---|---|---|
| [tailscale-connect](tailscale-connect.md) | ✓ Voltooid | ssh-setup |

## Monitoring & Beheer
| Skill | Status | Chains naar |
|---|---|---|
| [health-check](health-check.md) | ✓ Voltooid | morning-briefing |
| [backup-status](backup-status.md) | ✓ Voltooid | weekly-review |

## Data & Sync
| Skill | Status | Chains naar |
|---|---|---|
| [things-sync](things-sync.md) | ✓ Voltooid | morning-briefing, daily-report |

## Dagelijks
| Skill | Status | Chains naar |
|---|---|---|
| [morning-briefing](morning-briefing.md) | ✓ Voltooid | Telegram |

## Chains
```
Morning:  cron → things-sync → health-check → morning-briefing → Telegram
Daily:    cron → things-sync → git-log → daily-report → Telegram
Weekly:   cron → backup-status → things-sync → health-check → weekly-review → Telegram
```
