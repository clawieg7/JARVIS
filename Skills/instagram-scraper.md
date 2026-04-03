# Skill: Instagram Scraper

## Doel
Instagram posts analyseren zonder API toegang. Maximale datakwaliteit uit beperkte bronnen.

## KRITIEK: Bekende Beperkingen

Meta tag scraping is ONBETROUWBAAR voor carousel posts:
- og:image = alleen eerste slide, gecomprimeerd (640x640)
- Caption is vaak `null` in HTML response
- Bedragen, cijfers, details worden FOUT gelezen van thumbnails
- **Bewezen fout**: "$100 portfolio" gelezen waar "$50,000" stond (2026-04-03)

## Methode: Multi-Source met Verificatie

### Stap 1: Meta Tags ophalen (laagste betrouwbaarheid)
```bash
curl -s -L -H "User-Agent: Mozilla/5.0 (Macintosh)" \
  "https://www.instagram.com/p/POST_ID/" | grep -oE 'content="[^"]{20,}"'
```
Levert: og:image (slide 1 thumbnail), og:title (account), og:url

### Stap 2: Preview image downloaden
```bash
# Zoek og:image URL in meta tags output
curl -s -L -o "/tmp/ig_preview.jpg" "IMAGE_URL"
```

### Stap 3: Afbeelding analyseren via vision
```
Read tool → /tmp/ig_preview.jpg
```

### Stap 4: VERPLICHTE Verificatie
Na elke scrape, controleer:
- [ ] Komen cijfers/bedragen overeen met context?
- [ ] Is het een carousel? Zo ja: data is INCOMPLEET
- [ ] Zijn er screenshots van de gebruiker beschikbaar?
- [ ] Klopt de caption? (vaak null bij meta tags)

Als verificatie faalt → markeer data als ONBEVESTIGD.

### Stap 5: Carousel aanpak (meerdere slides)
Voor carousel posts (meest voorkomend op IG):
```bash
# Probeer specifieke slides via img_index parameter
curl -s -L -H "User-Agent: Mozilla/5.0 (Macintosh)" \
  "https://www.instagram.com/p/POST_ID/?img_index=2" | grep -oE 'content="[^"]{20,}"'
```
- Werkt niet altijd — Instagram serveert vaak dezelfde og:image
- Embed endpoint (`/p/POST_ID/embed/`) geeft soms 2-3 slides
- Voor volledige carousel: screenshots van gebruiker zijn DE ENIGE betrouwbare bron

## Betrouwbaarheidsniveaus

| Bron | Betrouwbaarheid | Wat je krijgt |
|---|---|---|
| Meta tags (og:image) | LAAG | Eerste slide thumbnail, vaak onleesbaar detail |
| Embed endpoint | MEDIUM | 2-3 slides, geen caption |
| Screenshots van gebruiker | HOOG | Alle slides, caption, engagement, exacte data |
| Instagram API (niet beschikbaar) | HOOGST | Alles |

## Workflow bij Instagram Link van Gijs

1. **Scrape meta tags** — voor basisinfo (account, URL)
2. **Download en lees preview** — voor globaal beeld
3. **Markeer alle cijfers/details als ONBEVESTIGD**
4. **Wacht op screenshots** of vraag Gijs om slides te delen
5. **Na screenshots**: corrigeer data, markeer als BEVESTIGD
6. **Sla op** in `Data/input/links.md` met verificatiestatus

## Template voor links.md entry

```markdown
- DATUM URL — @account: korte beschrijving
  - [BEVESTIGD/ONBEVESTIGD] kerndata
  - Details per slide
  - Engagement: X likes, Y comments, Z saves
  - Relevantie: waarom interessant
  - Verificatie: bron (meta tags / screenshots / beide)
```

## Geleerde Lessen

1. **Vertrouw NOOIT cijfers van thumbnails** — compressie maakt tekst onleesbaar
2. **Carousel = incompleet** — meta tags geven alleen slide 1
3. **Vraag screenshots** als details belangrijk zijn
4. **Markeer onzekerheid** expliciet — liever "onbevestigd" dan fout
5. **Instagram blokkeert steeds meer** — methode kan stoppen met werken

## Ketent naar
- capture-alles → inbox-verwerking → project herkenning
- Bij relevante content → project inbox of Data/input/ideas.md
