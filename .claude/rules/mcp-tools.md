# MCP Tools

## Beschikbare tools

| Tool | Gebruik | Authenticatie |
|------|---------|---------------|
| Google Calendar | Agenda lezen/schrijven, beschikbaarheid | OAuth |
| Gmail | Inbox lezen, drafts, zoeken | OAuth |
| Supabase | Database, migrations, edge functions | OAuth |
| Vercel | Deploy, logs, projecten | OAuth |
| Figma | Designs lezen, code genereren | OAuth |
| Context7 | Library/framework documentatie | Automatisch |
| Hugging Face | Models, papers, datasets | Token |

## Wanneer welke tool

- **Agenda nodig?** → Google Calendar MCP (`gcal_list_events`)
- **Mail checken?** → Gmail MCP (`gmail_search_messages`)
- **Docs opzoeken?** → Context7 (`resolve-library-id` → `query-docs`)
- **Database?** → Supabase MCP (`execute_sql`)
- **Deployen?** → Vercel MCP (`deploy_to_vercel`)

## Lokale tools (geen MCP)

| Tool | Hoe | Pad |
|------|-----|-----|
| Things 3 | SQLite query via Bash | `~/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite` |
| Weer | `curl wttr.in/Den+Haag?format=%C+%t&lang=nl` | — |
| Tailscale | `tailscale status` | — |
| Health check | `~/Claude/scripts/health-check.sh` | — |
