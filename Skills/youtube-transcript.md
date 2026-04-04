# Skill: YouTube Transcript

Haal transcript op van een YouTube video en converteer naar plain text voor analyse.

## Gebruik

```bash
python3 ~/Claude/scripts/youtube-transcript.py <URL>
```

Of direct in Claude:
```python
from youtube_transcript_api import YouTubeTranscriptApi
import re

def get_transcript(url, lang='nl'):
    vid = re.search(r'(?:v=|youtu\.be/|shorts/)([a-zA-Z0-9_-]{11})', url).group(1)
    api = YouTubeTranscriptApi()
    # Probeer voorkeurstaal, daarna Engels, daarna auto-generated
    for langs in [[lang], ['en'], None]:
        try:
            t = api.fetch(vid, languages=langs) if langs else api.fetch(vid)
            return ' '.join([s.text for s in t])
        except:
            continue
    return None
```

## Vereisten

```bash
pip3 install youtube-transcript-api
```

## Wanneer gebruiken

- YouTube video analyseren (inhoud, samenvatting, key points)
- Tutorial of talk naar tekst
- Transcript als context meegeven voor verdere verwerking

## Beperkingen

- Werkt alleen bij video's met captions (handmatig of auto-generated)
- Geen transcripts bij privévideo's of leeftijdsverificatie
- youtube-transcript.io als fallback (web UI, 25 gratis tokens/maand)

## Chain

`youtube-transcript` → analyseer met Claude → sla op als `Data/input/raw/`
