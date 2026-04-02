# Skill: GitHub Research

## Doel
GitHub gebruiken om betere tools, patterns en MCPs te vinden.

## Commando's

### Trending repos
```bash
gh api /search/repositories --method GET -f q="topic:mcp-server stars:>100" -f sort=stars | jq '.items[:10] | .[] | {name, url: .html_url, stars: .stargazers_count, desc: .description}'
```

### Zoek MCP servers
```bash
gh search repos "mcp server" --sort stars --limit 10
```

### Zoek Claude Code plugins
```bash
gh search repos "claude-code plugin" --sort stars --limit 10
```

### Best practices voor specifiek topic
```bash
gh search repos "things3 sync" --sort stars --limit 5
gh search repos "telegram bot typescript" --sort stars --limit 5
```

## Wanneer gebruiken
- Voor je begint aan een nieuw project/feature
- Wekelijks: check of er betere tools zijn
- Bij een probleem: zoek of iemand het al heeft opgelost

## Ketent naar
- autonomous-work → bij "niets te doen" fase
