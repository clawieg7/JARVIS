# Regels: Security

## .env bestanden
- Vault heeft één centrale `.env` in de root → projecten lezen van daar
- Elke project-map met een git repo MOET een `.gitignore` hebben met `.env` erin
- Vault-level `.gitignore` bevat altijd `.env`
- Nooit `.env` dupliceren in subprojecten — gebruik symlink of verwijs naar root
- `.env.example` WEL committen (zonder waarden) als template

## Bij elk nieuw project
Controleer altijd:
- [ ] `.gitignore` aanwezig met: `.env`, `node_modules/`, `dist/`, `.DS_Store`
- [ ] Geen secrets in code of markdown bestanden
- [ ] `.env.example` aangemaakt als het project env vars gebruikt

## iCloud + GitHub
- Vault zit in iCloud én GitHub backup → dubbele sync
- Alles wat je NIET wilt exposen: in `.gitignore` vault root
- Projecten met eigen repo: uitgesloten in vault `.gitignore` (eigen git beheer)

## Wanneer een nieuwe regel toevoegen
Als je tijdens werk een security-risico ontdekt of een patroon dat fout kan gaan → voeg het direct toe aan dit bestand.
