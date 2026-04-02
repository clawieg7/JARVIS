# MCP Tools

## Cloud MCPs (via claude.ai)

- **Google Calendar** — agenda lezen/schrijven (`gcal_list_events`)
- **Gmail** — inbox lezen, drafts, zoeken (`gmail_search_messages`)
- **Supabase** — database, migrations, edge functions (`execute_sql`)
- **Vercel** — deploy, logs, projecten (`deploy_to_vercel`)
- **Figma** — designs lezen, code genereren
- **Context7** — library/framework documentatie (`resolve-library-id` → `query-docs`)
- **Hugging Face** — models, papers, datasets
- **Canva** — designs maken/bewerken
- **Granted** — grants zoeken

## Lokale MCPs (geïnstalleerd op Mac)

- **Apple MCP** — Calendar, Reminders, Notes, Contacts, Mail, Maps (native macOS)
- **Obsidian MCP** — vault doorzoeken, notes lezen/schrijven/taggen (`search-vault`, `read-note`)
- **Playwright MCP** — headless browser automation (Chromium)
- **Things 3 MCP** — todo read/write (als geïnstalleerd)

## Wanneer welke tool

- **Agenda?** → Apple MCP (lokaal) of Google Calendar MCP (cloud)
- **Mail?** → Gmail MCP (cloud) of Apple MCP Mail (lokaal)
- **Obsidian vault doorzoeken?** → Obsidian MCP (`search-vault`)
- **Website testen/scrapen?** → Playwright MCP
- **Docs opzoeken?** → Context7
- **Database?** → Supabase MCP
- **Deployen?** → Vercel MCP

## Lokale tools (geen MCP)

- **Things 3 SQLite** — `~/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-00IDD/Things Database.thingsdatabase/main.sqlite`
- **Weer** — `curl wttr.in/Den+Haag?format=%C+%t&lang=nl`
- **Tailscale** — `tailscale status`
- **Health check** — `~/Claude/scripts/health-check.sh`
- **Ollama fallback** — `~/Claude/scripts/fallback-chat.sh`
