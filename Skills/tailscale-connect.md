# Skill: tailscale-connect

## Doel
Verbind de Mac met het Tailscale netwerk voor remote toegang.

## Wanneer gebruiken
- Bij eerste setup van remote access
- Als Tailscale verbinding verloren is
- Na herstart van de Mac

## Commando's
```bash
# Start daemon (eenmalig / na herstart)
brew services start tailscale

# Verbinden + inloggen (opent browser link)
sudo tailscale up

# Status checken
tailscale status

# IP opvragen
tailscale ip -4
```

## Chaining
- Na verbinding → `ssh-setup` skill (SSH via Tailscale IP)
- Controleer altijd met `tailscale status` voor je remote werk start

## Afhankelijkheden
- tailscale geïnstalleerd via brew
- LaunchAgent actief (auto-start bij login)
