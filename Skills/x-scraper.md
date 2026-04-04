# Skill: X/Twitter Scraper

## Doel
X (Twitter) posts en articles analyseren zonder API key of login.

## Methode: FxTwitter API (beste optie)

### Stap 1: Tweet ophalen
```bash
curl -s "https://api.fxtwitter.com/USERNAME/status/TWEET_ID"
```

### Stap 2: Data extracten
```bash
curl -s "https://api.fxtwitter.com/USERNAME/status/TWEET_ID" | python3 -c "
import sys, json
d = json.load(sys.stdin)
t = d.get('tweet', {})
print(f\"Author: {t['author']['name']} (@{t['author']['screen_name']})\")
print(f\"Text: {t['text']}\")
print(f\"Likes: {t['likes']} | RT: {t['retweets']} | Views: {t.get('views',0)}\")

article = t.get('article', {})
if article:
    print(f\"Article: {article.get('title','')}\")
    for b in article.get('content',{}).get('blocks',[]):
        print(b.get('text',''))
"
```

### Stap 3: URL parsing
Tweet URL formaat: `https://x.com/USERNAME/status/TWEET_ID`
- USERNAME en TWEET_ID extraheren uit URL
- Werkt ook met twitter.com URLs

## Fallback: CDN Syndication
```bash
curl -s "https://cdn.syndication.twimg.com/tweet-result?id=TWEET_ID&token=x"
```
- Twitter's eigen embed endpoint
- Minder data dan FxTwitter maar stabieler
- Geen volledige article body

## Fallback: oEmbed
```bash
curl -s "https://publish.twitter.com/oembed?url=TWEET_URL"
```
- Alleen basis: auteur naam + tweet tekst als HTML
- Geen media, geen articles, geen metrics

## Wat NIET werkt (2026)
- Nitter: alle instances dood
- Guest token API: v1.1 endpoints locked
- Direct scrapen: X serveert alleen JS shell
- vxTwitter: geen volledige article body

## Betrouwbaarheidsniveaus

| Bron | Betrouwbaarheid | Wat je krijgt |
|---|---|---|
| FxTwitter API | HOOG | Alles: tekst, media, articles, metrics, author |
| CDN Syndication | MEDIUM | Tweet + article preview, geen full body |
| oEmbed | LAAG | Alleen tekst + auteur naam |

## Workflow bij X link van Gijs

1. Parse USERNAME en TWEET_ID uit URL
2. Fetch via FxTwitter API
3. Extract: tekst, article content, media, metrics
4. Sla raw op in `Data/input/raw/`
5. Sla samenvatting op in `Data/input/links.md` met [BEVESTIGD]
6. Bepaal project routing
7. Converteer inzichten naar taken/actiepunten in juiste inbox

## Ketent naar
- capture-alles → inbox-verwerking → project herkenning
