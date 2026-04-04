# Skill: SSH Setup

## Doel
SSH configureren via Tailscale voor remote toegang tot de Mac Mini.

## Wanneer gebruiken
- Na `tailscale-connect` skill (eerste keer of na reset)
- Bij SSH verbindingsproblemen
- Bij setup van nieuwe client die remote wil verbinden

## Configuratie

### Mac Mini (server)
```bash
# SSH inschakelen (System Settings > General > Sharing > Remote Login)
# Of via CLI:
sudo systemsetup -setremotelogin on

# Alleen key-based auth toestaan
sudo sed -i '' 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i '' 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo launchctl stop com.openssh.sshd
sudo launchctl start com.openssh.sshd
```

### Client SSH config
```bash
# ~/.ssh/config toevoegen:
Host jarvis
    HostName 100.82.231.116
    User jarvis
    IdentityFile ~/.ssh/id_ed25519
    ForwardAgent yes
```

### Tailscale IP
```
100.82.231.116
```

## Commando's

### Verbinding testen
```bash
# Via Tailscale IP
ssh jarvis@100.82.231.116

# Via config alias
ssh jarvis
```

### Key genereren (client)
```bash
ssh-keygen -t ed25519 -C "jarvis-remote"
ssh-copy-id -i ~/.ssh/id_ed25519.pub jarvis@100.82.231.116
```

### Troubleshooting
```bash
# Check of SSH draait
sudo launchctl list | grep ssh

# Check Tailscale verbinding
tailscale ping 100.82.231.116

# Verbose SSH voor debugging
ssh -vvv jarvis@100.82.231.116
```

## Chaining
- Voor deze skill: `tailscale-connect` (Tailscale moet actief zijn)
- Na deze skill: remote sessies, tmux attach, health-check remote

## Afhankelijkheden
- Tailscale actief en verbonden
- Remote Login ingeschakeld op Mac Mini
- SSH key pair gegenereerd en gekopieerd
