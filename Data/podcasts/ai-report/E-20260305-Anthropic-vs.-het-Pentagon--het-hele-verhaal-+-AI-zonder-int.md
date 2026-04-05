# Anthropic vs. het Pentagon: het hele verhaal + AI zonder internet op je smartphone + nerden in de...

- Datum: 2026-03-05
- Duur: 1:22:53
- Bron: https://www.youtube.com/watch?v=mXiE_Rns-FM
- Status: VERWERKT — 2026-04-05

## Description
Anthropic ligt op ramkoers met het Pentagon en staat inmiddels officieel op de zwarte lijst van het Amerikaanse ministerie van Defensie. Het bedrijf weigerde twee grenzen los te laten: geen AI voor massasurveillance van Amerikaanse burgers en geen autonome wapens. Trump gebood alle federale diensten per direct te stoppen met Anthropic-producten, terwijl OpenAI 4,5 uur na de breuk een deal tekende met het leger. Het conflict heeft diepe wortels: Claude draait ingebouwd in Palantirs Maven-systeem en werd tijdens de aanval op Iran gebruikt om meer dan duizend doelwitten te identificeren. Wietse en Alexander worstelen met de vraag of een techbedrijf het buitenlandbeleid van een democratie mag bepalen, en of Anthropic volksheld of hypocriet is. Het antwoord is complexer dan beide kampen willen toegeven: dezelfde week schrapte Anthropic stilletjes de kernbelofte om nooit een model te trainen zonder garanties over veiligheid.
    

Ondertussen bracht het Chinese Alibaba met Qwen 3.5 het eerste open source model uit dat daadwerkelijk iets zinnigs kan op een smartphone, zonder internetverbinding. Het 9B-model scoort op universitair niveau hoger dan OpenAI’s dertienmaal grotere model. Wietse legt uit wat dat betekent: de grote modellen bevatten blijkbaar nog enorm veel ballast die we niet nodig hebben, en de combinatie van snellere telefoonchips en slimmere kleine modellen brengt “good enough AI” in je broekzak. Dat klinkt als vrijheid, maar de keerzijde is dat je ook alle vangrails kwijtraakt die nu voorkomen dat AI wordt misbruikt voor pesten, spam of deepfakes.
    

En, Alexander heeft zijn nerdstatus definitief verdiend door in een treinrit zijn eigen e-mailclient te bouwen in de terminal. Wat begon als frustratie over wachttijden bij AI-gegenereerde mails groeide uit tot een centrale verkeerstoren: samenvattingen bovenaan elke thread, automatische taakherkenning, en straks ook WhatsApp erbij. Wietse snapt waarom de terminal de perfecte plek is om te beginnen: de beperkingen dwingen je na te denken over de kern van je probleem, en het AI-model spreekt de taal van de tool.
    

Voeg voor gegarandeerde deliverability ai-report@mail.beehiiv.com alvast toe aan je contacten (dat zijn inderdaad twee ii’s) én maandag ontvang je nog een email in je inbox met meer details!
    

De masterclass is morgen terug te kijken, als je betaald abonnee bent ontvang je deze in je mailbox.
    

Als je een lezing wil over AI van Wietse of Alexander dan kan dat. Mail ons op lezing@aireport.email (http://deptagency.com/aireport) 
    

This is a public episode. If you would like to discuss this with other subscribers or get access to bonus episodes, visit
    

www.aireport.email (https://www.aireport.email?utm_medium=podcast&utm_campaign=CTA_1)

## Topics


## Kern

### 1. Anthropic op Pentagon zwarte lijst ✅ GEVERIFIEERD
Trump beval alle federale diensten om per direct te stoppen met Anthropic. Defense Secretary Hegseth wees Anthropic aan als "Supply-Chain Risk to National Security". Anthropic weigerde twee grenzen: geen AI voor massasurveillance van Amerikaanse burgers, geen autonome wapens. Anthropic heeft teruggevochten — rechter Rita Lin blokkeerde de blacklist op 26 maart via preliminary injunction, noemde het "classic illegal First Amendment retaliation". Pentagon ging in beroep op 2 april.
- Bronnen: CNBC (2026-03-09), NPR (2026-03-26), WaPo (2026-02-27), Axios (2026-02-27)

### 2. Claude + Palantir Maven = 1000+ Iran targets in 24u ✅ GEVERIFIEERD
Claude draait ingebouwd in Palantir's Maven-systeem. Tijdens eerste 24u van de Iran-campagne: ~1000 geprioriteerde targets met GPS-coördinaten, wapen-aanbevelingen, juridische rechtvaardigingen. Totaal 11.000 targets sinds oorlog begon. Pentagon onderzoekt of AI rol speelde bij school-strike (170+ doden, voornamelijk meisjes). Maven objectherkenning: 60% accuraat vs 84% human analysts.
- Bronnen: WaPo (2026-03-04), Responsible Statecraft, Democracy Now (2026-03-18, 2026-03-31), Military Times

### 3. Qwen 3.5 9B: on-device AI doorbraak ✅ GEVERIFIEERD
Alibaba release 1 maart 2026: Qwen 3.5 Small family (0.8B/2B/4B/9B). Qwen3.5-9B verslaat OpenAI's gpt-oss-120B (13x groter!) op multilingual knowledge + graduate-level reasoning. MMMU-Pro: 70.1 vs Gemini 2.5 Flash-Lite 59.7. Draait op iPhone 17 (quantized 2B), standaard laptops (9B). Hybrid architectuur: Gated Delta Networks + sparse MoE. Open-weight license.
- Bronnen: VentureBeat, MarkTechPost (2026-03-02), TechEBlog, MindStudio

### 4. Anthropic schrapte safety-training belofte ⚠️ CONTEXT
Volgens episode: zelfde week als Pentagon-conflict schrapte Anthropic stilletjes de kernbelofte om nooit een model te trainen zonder garanties over veiligheid. Niet direct geverifieerd in searches, maar past bij patroon van Anthropic's Responsible Scaling Policy revisies in 2025-2026.

### 5. Terminal email client in treinrit gebouwd (Alexander Klopping) 💡 INSPIRATIE
Alexander's workflow: samenvattingen bovenaan elke thread, auto taakherkenning, WhatsApp integration planned. Terminal = AI model "spreekt taal van de tool". Constraint-driven development dwingt kerndenken.

## Relevant voor Gijs

**Direct relevant voor Jarvis:**
- **Qwen 3.5 9B on-device**: perfect voor Jarvis edge fallback op Mac mini als Claude API down is. 9B draait prima lokaal, geen API costs. Raakt ook `~/Claude/scripts/fallback-chat.sh` (Ollama).
- **Vendor lock-in risk**: Anthropic-Pentagon conflict toont hoe snel een AI provider geopolitiek verwikkeld raakt. Jarvis is 100% Claude-afhankelijk — risico beoordelen.
- **Terminal tooling pattern**: Alexander's email client in terminal = exact Gijs' TypeScript-first + CLI ethos. Inspiratie voor Jarvis features (mail triage UI, dashboard).

**Strategisch:**
- Ethiek AI vendors wordt koopcriterium — Anthropic's "no surveillance, no autonomous weapons" positie is differentiator.
- Open-weight modellen op mobiel = nieuwe laag: personal AI zonder cloud-afhankelijkheid.

## Actiepunten

→ Jarvis inbox (deze file):
- [ ] Test Qwen 3.5 9B lokaal op Mac mini (via MLX of Ollama) als edge-fallback voor Jarvis
- [ ] Evalueer vendor lock-in risico Jarvis: hoe snel kan Jarvis switchen naar open model als Claude wegvalt?
- [ ] Onderzoek Alexander Klopping's terminal email client pattern → mogelijk feature voor Jarvis (mail triage in terminal)

→ Lange termijn / research:
- [ ] Lees Responsible Statecraft + Democracy Now stukken over Claude-Maven voor diepere context
