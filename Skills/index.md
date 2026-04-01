# Skills index

Herbruikbare procedures voor Jarvis en development workflow.

## Regels
- `_skill-template.md` — template voor nieuwe skills
- `_skill-herkenning.md` — wanneer en hoe iets een skill wordt

## Skills

### Remote & Connectiviteit
| Skill | Doel | Chains naar |
|---|---|---|
| [tailscale-connect](tailscale-connect.md) | Mac verbinden met Tailscale netwerk | ssh-setup |
| ssh-setup | SSH toegang via Tailscale IP | claude-remote |
| claude-remote | Claude Code remote sessie starten | file-watcher |

### Automatisering
| Skill | Doel | Chains naar |
|---|---|---|
| file-watcher | Development/ bewaken, inbox wijzigingen oppikken | claude-remote |

> Skills zonder link zijn nog niet aangemaakt.
