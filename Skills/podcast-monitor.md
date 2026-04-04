# Skill: Podcast Monitor

## Doel
Nieuwe podcast episodes detecteren, analyseren, fact-checken en key inzichten via Telegram delen met Gijs.

## Workflow per nieuwe episode

### 1. Detectie (automatisch, nightly loop)
```bash
# AI Report — check YouTube voor nieuwe episodes
python3 -m yt_dlp --skip-download --print "%(title)s|||%(upload_date)s|||%(duration_string)s|||%(webpage_url)s" "ytsearch1:AI Report Alexander Klopping Wietse 2026" 2>/dev/null

# All-In — check YouTube
python3 -m yt_dlp --skip-download --print "%(title)s|||%(upload_date)s|||%(duration_string)s|||%(webpage_url)s" "ytsearch1:All-In Podcast 2026" 2>/dev/null

# Vergelijk met laatst bekende episode in Data/podcasts/[naam]/
# Nieuwe episode? → start analyse
```

### 2. Analyse
```
- Description ophalen (yt-dlp --print "%(description).3000s")
- Timestamps en topics extraheren
- Referenced links resolven en ophalen
- Transcript proberen (auto-subs als beschikbaar)
- Kern extraheren: 3-5 key inzichten
```

### 3. Fact-check & Deep Dive
Per key inzicht:
```
- Claim verifiëren via WebFetch/WebSearch
- Bron en oorsprong opzoeken (wie zei het eerst? paper? data?)
- Tegenargumenten zoeken
- Relevantie voor Gijs bepalen (welk project/doel?)
- Markeer: ✅ bevestigd | ⚠️ nuance nodig | ❌ onjuist/overdreven
```

### 4. Opslaan
```
Data/podcasts/[podcast]/E[nr]-[datum]-[titel].md
```

### 5. Telegram — twee berichten

**Bericht 1: Direct bij detectie (check-podcasts.sh)**
```
🎙️ *Nieuwe [Podcast Naam]*

📌 [Episode titel]
⏱️ [duur] | 📅 [datum]

📋 *Topics:*
  • (0:00) [topic 1]
  • (15:30) [topic 2]
  • (32:00) [topic 3]

🔗 [YouTube link]

⏳ Deep analyse volgt...
```

**Bericht 2: Na deep analyse (nightly learn / claude-rc)**
```
🎙️ *[Podcast Naam] — Analyse*

📌 [Episode titel]

🔑 *Key inzichten:*
1. [inzicht] ✅ bevestigd — bron: [link/paper]
2. [inzicht] ⚠️ nuance: [wat klopt niet helemaal]
3. [inzicht] ✅ bevestigd — bron: [link]

💡 *Relevant voor jou:*
• [project]: [waarom + wat het betekent]
• [doel]: [concrete impact]

📋 *Actiepunten (in inbox gezet):*
• [taak 1] → [project]
• [taak 2] → [project]

🔍 *Bronnen gecheckt:*
• [bron 1] — [wat het bevestigt/ontkracht]
• [bron 2]
```

### Check frequentie
- **3x per dag**: 08:00, 14:00, 20:00 (LaunchAgent)
- **1x per nacht**: 00:30 (nightly-learn loop)
- Bij detectie: direct Telegram + trigger deep analyse

## Podcasts die gemonitord worden

| Podcast | Check frequentie | YouTube search query |
|---|---|---|
| AI Report | dagelijks | "AI Report Alexander Klopping Wietse" |
| All-In | dagelijks | "All-In Podcast Chamath Sacks" |

## Ketent naar
- nightly-learn loop → detectie
- capture-alles → opslaan
- inbox-verwerking → actiepunten routeren
- notify-telegram → Gijs informeren
