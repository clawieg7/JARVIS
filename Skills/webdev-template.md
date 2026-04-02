# Webdev Template - Jarvis Project Ecosystem

Standaard webontwikkeling template voor alle nieuwe webprojecten binnen het Jarvis ecosysteem.

---

## Vaste Stack

| Technologie | Versie / Variant |
|---|---|
| Next.js | 14+ (App Router) |
| TypeScript | Strict mode |
| Tailwind CSS | Latest |
| ESLint | Flat config (eslint.config.mjs) |
| Prettier | Latest |
| Deploy target | Vercel |

Geen afwijkingen zonder expliciete onderbouwing.

---

## 1. Standaard Projectstructuur

Bij elk nieuw project wordt deze structuur aangehouden:

```
project-name/
  app/
    layout.tsx          # Root layout met metadata, fonts, analytics
    page.tsx            # Homepage
    globals.css         # Tailwind directives + minimale global styles
  components/           # Herbruikbare UI-componenten (PascalCase)
    Header.tsx
    Footer.tsx
  lib/                  # Utility functies, helpers, constanten
    utils.ts
    constants.ts
  public/               # Statische assets (images, fonts, favicon)
  .env.example          # Template voor environment variables (ALTIJD aanwezig)
  .gitignore
  package.json
  tsconfig.json
  tailwind.config.ts
  postcss.config.js
  next.config.js
  eslint.config.mjs     # Flat config (NIET .eslintrc)
  prettier.config.js
```

### Naamconventies

- **Componenten**: PascalCase (`Header.tsx`, `ContactForm.tsx`)
- **Pagina's**: lowercase kebab-case (`app/over-ons/page.tsx`, `app/contact/page.tsx`)
- **Utility bestanden**: camelCase (`utils.ts`, `formatDate.ts`)

---

## 2. ESLint Configuratie

Gebruik ESLint flat config (`eslint.config.mjs`). Geen legacy `.eslintrc` bestanden.

### Benodigde packages

```bash
npm install -D eslint @eslint/js typescript-eslint eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y @next/eslint-plugin-next eslint-config-prettier
```

### eslint.config.mjs

```js
import js from "@eslint/js";
import tseslint from "typescript-eslint";
import react from "eslint-plugin-react";
import reactHooks from "eslint-plugin-react-hooks";
import jsxA11y from "eslint-plugin-jsx-a11y";
import nextPlugin from "@next/eslint-plugin-next";

export default tseslint.config(
  js.configs.recommended,
  ...tseslint.configs.strict,
  {
    files: ["**/*.{ts,tsx}"],
    plugins: {
      react,
      "react-hooks": reactHooks,
      "jsx-a11y": jsxA11y,
      "@next/next": nextPlugin,
    },
    rules: {
      // TypeScript strict rules
      "@typescript-eslint/no-unused-vars": "error",
      "@typescript-eslint/no-explicit-any": "error",
      "@typescript-eslint/explicit-function-return-type": "warn",
      "@typescript-eslint/no-non-null-assertion": "error",

      // React rules
      "react/react-in-jsx-scope": "off",
      "react/prop-types": "off",
      "react/jsx-no-target-blank": "error",

      // React Hooks
      "react-hooks/rules-of-hooks": "error",
      "react-hooks/exhaustive-deps": "warn",

      // Accessibility
      "jsx-a11y/alt-text": "error",
      "jsx-a11y/anchor-is-valid": "error",
      "jsx-a11y/aria-props": "error",
      "jsx-a11y/aria-role": "error",
      "jsx-a11y/heading-has-content": "error",
      "jsx-a11y/html-has-lang": "error",
      "jsx-a11y/img-redundant-alt": "error",
      "jsx-a11y/label-has-associated-control": "error",
      "jsx-a11y/no-autofocus": "warn",

      // Next.js
      "@next/next/no-html-link-for-pages": "error",
      "@next/next/no-img-element": "error",

      // General
      "no-console": "warn",
      "prefer-const": "error",
    },
    settings: {
      react: {
        version: "detect",
      },
    },
  },
  {
    ignores: [".next/", "node_modules/", "out/"],
  }
);
```

---

## 3. Prettier Configuratie

### prettier.config.js

```js
/** @type {import("prettier").Config} */
const config = {
  semi: true,
  singleQuote: false,
  tabWidth: 2,
  trailingComma: "es5",
  printWidth: 100,
  plugins: ["prettier-plugin-tailwindcss"],
};

export default config;
```

```bash
npm install -D prettier prettier-plugin-tailwindcss
```

---

## 4. TypeScript Configuratie

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [{ "name": "next" }],
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

---

## 5. npm Scripts

Standaard scripts in `package.json`:

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write .",
    "typecheck": "tsc --noEmit",
    "check": "npm run typecheck && npm run lint && npm run build"
  }
}
```

Het `check` script is de volledige verificatie: typecheck + lint + build. Draai dit altijd voor deploy.

---

## 6. SEO Checklist (verplicht per pagina)

SEO is geen optie, het is een vereiste. Elke pagina moet voldoen aan:

### Metadata (per pagina)

- [ ] **Title tag** - Uniek per pagina, max 60 karakters
- [ ] **Meta description** - Uniek, 150-160 karakters
- [ ] **OG tags** - title, description, image, url
- [ ] **Twitter card tags** - card type, title, description, image
- [ ] **Canonical URL** - Voorkom duplicate content

### Next.js Metadata API voorbeeld

```tsx
// app/page.tsx
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Paginatitel | Sitenaam",
  description: "Unieke beschrijving van 150-160 karakters voor deze specifieke pagina.",
  openGraph: {
    title: "Paginatitel | Sitenaam",
    description: "Unieke beschrijving voor social media.",
    url: "https://example.com",
    siteName: "Sitenaam",
    images: [
      {
        url: "https://example.com/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "Beschrijving van de afbeelding",
      },
    ],
    locale: "nl_NL",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Paginatitel | Sitenaam",
    description: "Unieke beschrijving voor Twitter.",
    images: ["https://example.com/og-image.jpg"],
  },
  alternates: {
    canonical: "https://example.com",
  },
};
```

### JSON-LD Structured Data

Elke site heeft minimaal een `WebSite` of `Organization` schema. Artikelen krijgen `Article`.

```tsx
// components/JsonLd.tsx
export function WebSiteJsonLd({ name, url }: { name: string; url: string }) {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name,
    url,
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}
```

### Technische SEO bestanden

```tsx
// app/robots.ts
import { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: "/",
      disallow: "/api/",
    },
    sitemap: "https://example.com/sitemap.xml",
  };
}
```

```tsx
// app/sitemap.ts
import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  return [
    {
      url: "https://example.com",
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 1,
    },
  ];
}
```

### Semantische HTML

- Correcte heading hierarchie (h1-h6, slechts 1 h1 per pagina)
- Gebruik van `<nav>`, `<main>`, `<article>`, `<section>`, `<footer>`
- Alle afbeeldingen hebben een `alt` attribuut
- Links hebben beschrijvende tekst (geen "klik hier")

### Core Web Vitals targets

| Metric | Target | Meting |
|---|---|---|
| LCP (Largest Contentful Paint) | < 2.5s | Laadtijd grootste element |
| FID (First Input Delay) | < 100ms | Reactietijd op eerste interactie |
| CLS (Cumulative Layout Shift) | < 0.1 | Visuele stabiliteit |

---

## 7. Eind-check voor Deploy

Deze checklist wordt bij ELKE deploy doorlopen. Geen uitzonderingen.

### Automatische checks (via `npm run check`)

```bash
# 1. TypeScript compileert zonder fouten
npx tsc --noEmit

# 2. ESLint slaagt (inclusief a11y rules)
npx eslint .

# 3. Build slaagt
npx next build
```

### Handmatige checks

- [ ] **Geen .env secrets gecommit** - Controleer `.gitignore`, alleen `.env.example` in repo
- [ ] **SEO compleet** - Elke pagina heeft title, description, OG tags
- [ ] **Accessibility** - Geen a11y warnings van eslint-plugin-jsx-a11y
- [ ] **Performance** - Static generation waar mogelijk (`generateStaticParams`)
- [ ] **Mobile responsive** - Alle breakpoints getest (sm, md, lg, xl)
- [ ] **Afbeeldingen** - Next.js `<Image>` component gebruikt, alt tekst aanwezig
- [ ] **.gitignore compleet** - `.next/`, `node_modules/`, `.env.local`, `out/`
- [ ] **Environment variables** - `.env.example` bijgewerkt met alle benodigde variabelen

### Deploy commando

```bash
# Volledige verificatie + deploy
npm run check && vercel --prod
```

---

## 8. .gitignore Template

```gitignore
# Dependencies
node_modules/

# Next.js
.next/
out/

# Environment
.env
.env.local
.env.production.local
.env.development.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts
```

---

## 9. Snelstart Nieuw Project

```bash
# 1. Project aanmaken
npx create-next-app@latest project-name --typescript --tailwind --eslint --app --src-dir=false --import-alias="@/*"

# 2. Extra dependencies
cd project-name
npm install -D prettier prettier-plugin-tailwindcss eslint-plugin-jsx-a11y eslint-config-prettier

# 3. Configuratie bestanden aanmaken
# - Kopieer eslint.config.mjs uit dit template
# - Kopieer prettier.config.js uit dit template
# - Maak .env.example aan

# 4. Verifieer setup
npm run check
```
