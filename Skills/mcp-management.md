# Skill: MCP Management

## Doel
MCP servers vinden, installeren, configureren en gebruiken.

## Huidige MCP servers
Zie `.claude/rules/mcp-tools.md` voor volledige lijst.

## Nieuwe MCP server toevoegen

### 1. Vind
```bash
gh search repos "mcp server" --sort stars --limit 20
```
Of check: https://github.com/modelcontextprotocol/servers

### 2. Installeer
Via claude.ai MCP connectors, of lokaal:
```bash
npx @modelcontextprotocol/create-server my-server
```

### 3. Configureer
In `~/.claude/settings.json` onder `mcpServers`:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "my-mcp-server"],
      "env": {}
    }
  }
}
```

### 4. Test
Start Claude Code en verifieer met `/mcp` commando.

### 5. Documenteer
Update `.claude/rules/mcp-tools.md` met:
- Naam, wat het doet, authenticatie, wanneer gebruiken

## Ketent naar
- groei → github-research
