# Webdev Rules - Jarvis Project Ecosystem

Regels voor alle webontwikkeling binnen Jarvis projecten. Deze regels zijn niet optioneel.

---

## Vaste Stack

Gebruik ALTIJD de volgende stack voor webprojecten:

- **Next.js 14+** met App Router (geen Pages Router)
- **TypeScript** in strict mode
- **Tailwind CSS** voor styling
- **ESLint** flat config (eslint.config.mjs) met strikte regels
- **Prettier** voor formatting
- **Deploy target**: Vercel

Afwijkingen alleen met expliciete, gedocumenteerde reden.

---

## Code Conventies

### Naamgeving

- **Componenten**: PascalCase (`Header.tsx`, `ContactForm.tsx`, `NavLink.tsx`)
- **Pagina's**: lowercase kebab-case (`app/over-ons/page.tsx`, `app/blog/[slug]/page.tsx`)
- **Utility bestanden**: camelCase (`utils.ts`, `formatDate.ts`)
- **Constanten**: UPPER_SNAKE_CASE (`MAX_ITEMS`, `API_BASE_URL`)

### Styling

- Gebruik Tailwind utility classes. Geen custom CSS tenzij strikt noodzakelijk.
- Mobile-first design: begin met de kleinste viewport, voeg breakpoints toe met `sm:`, `md:`, `lg:`, `xl:`.
- Geen inline styles. Geen CSS modules tenzij uitzonderlijk geval.

### Componenten

- Een component per bestand.
- Props altijd getypt met TypeScript interface of type.
- Gebruik `function` declarations voor componenten, geen arrow functions op top level.
- Destructure props in de functiesignatuur.

```tsx
// Correct
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: "primary" | "secondary";
}

export function Button({ label, onClick, variant = "primary" }: ButtonProps) {
  return (
    <button onClick={onClick} className={variant === "primary" ? "bg-blue-600" : "bg-gray-600"}>
      {label}
    </button>
  );
}
```

---

## SEO is Verplicht

SEO is geen "nice-to-have". Elke pagina MOET bevatten:

1. **Unieke title tag** (max 60 karakters)
2. **Unieke meta description** (150-160 karakters)
3. **Open Graph tags** (title, description, image, url)
4. **Twitter card tags**
5. **Canonical URL**

Daarnaast per project:

- `robots.ts` in de app directory
- `sitemap.ts` in de app directory
- JSON-LD structured data (minimaal WebSite of Organization)
- Semantische HTML (correcte heading hierarchie, landmark elementen)
- Alt tekst op alle afbeeldingen

Gebruik de Next.js Metadata API. Geen handmatige `<head>` manipulatie.

---

## Rendering Strategie

- **Static generation** heeft de voorkeur boven SSR.
- Gebruik `generateStaticParams` voor dynamische routes waar mogelijk.
- Server Components zijn de default. Gebruik `"use client"` alleen wanneer nodig (interactie, hooks, browser APIs).
- Geen onnodige client-side data fetching. Fetch op de server waar mogelijk.

---

## Environment Variables

- `.env.example` is ALTIJD aanwezig in de repository.
- Bevat alle benodigde variabelen met lege waarden of placeholder beschrijvingen.
- `.env`, `.env.local`, en `.env.production.local` staan in `.gitignore`.
- Commit NOOIT echte secrets.

---

## ESLint & Code Quality

- ESLint MOET slagen voor deploy. Geen `eslint-disable` zonder commentaar met uitleg.
- Gebruik flat config (`eslint.config.mjs`), geen legacy `.eslintrc`.
- Accessibility regels (jsx-a11y) zijn verplicht, niet optioneel.
- `no-explicit-any` is een error. Type alles correct.
- `no-unused-vars` is een error. Geen dode code.

---

## Deploy Checklist

Voor ELKE deploy:

```bash
npm run check   # = typecheck + lint + build
```

Dit moet foutloos draaien. Daarnaast handmatig controleren:

- Geen .env secrets in de repository
- Alle pagina's hebben volledige SEO metadata
- Mobile responsive op alle breakpoints
- `.env.example` is bijgewerkt

---

## Afbeeldingen

- Gebruik ALTIJD de Next.js `<Image>` component, nooit `<img>`.
- Elke afbeelding heeft een beschrijvend `alt` attribuut.
- Gebruik WebP of AVIF formaat waar mogelijk.
- Definieer `width` en `height` om CLS te voorkomen.

---

## Performance Targets

| Metric | Target |
|---|---|
| LCP | < 2.5s |
| FID | < 100ms |
| CLS | < 0.1 |

Meet met Lighthouse en/of Vercel Analytics.
