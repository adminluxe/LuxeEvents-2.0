# Purple Events

Refonte premium bilingue de LuxeEvents vers **Purple Events**.

## Source of Truth

- Dépôt canonique : `adminluxe/LuxeEvents-2.0`
- Branche source élue : `feat/pimp-phase1-hero-services`
- Commit source : `bfdefda624b8342e902427cd24b446a81d2e7b96`
- Branche de travail : `luxeevents-ultra-polish-v1`
- Domaine cible : `purpleevents.fun`

## Commandes

```bash
corepack pnpm install --frozen-lockfile
corepack pnpm@8.15.4 check
corepack pnpm@8.15.4 preview
```

Le mode par défaut du formulaire ne transmet aucune donnée : il génère un brief et le copie localement. Avant l’ouverture publique, configurer l’identité juridique et un canal validé dans `.env.production.local` à partir de `.env.example`, puis exécuter :

```bash
corepack pnpm@8.15.4 check:launch
```

Consulter `docs/ROADBOOK.md`, `docs/ARCHITECTURE.md`, `docs/TRUTH_MAP.md` et `docs/LEGAL_SEO_LAUNCH_GATE.md` avant tout déploiement.
