#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
OWNER="adminluxe"; REPO="LuxeEvents-2.0"
BR="docs/release-v2.5.3-$(date +%Y%m%d-%H%M%S)"

cd "$REPO_DIR"
git fetch origin --prune
git checkout -B "$BR" origin/main || git checkout -b "$BR"

# CHANGELOG.md (v2.5.2 + v2.5.3)
cat > CHANGELOG.md <<'MD'
# Changelog — LuxeEvents

## [v2.5.3] — 2025-08-25
### Last-mile polish (SEO / Perf / A11Y)
- **SEO**: `canonical`, `description`, `theme-color`, **Open Graph** (title/description/url/image), **Twitter Card**.
- **Perf**: `preconnect` Google Fonts, **preload** héro `bg-luxeevents.png` (LCP).
- **Galerie**: `loading="lazy"` + `decoding="async"` sur les vignettes pour réduire le coût initial et le **CLS**.
- **Structured Data**: JSON-LD **Organization** + **WebSite**.
- **Robots / Sitemap**: ajout de `robots.txt` et `sitemap.xml`.
- **PWA safe**: garde SW (enregistre `/sw.js` uniquement s’il existe).
- **Infra**: livraison via PR (#15) avec check requis **Vercel** (Cloudflare Pages non bloquant).

## [v2.5.2] — 2025-08-24
### Hotfix prod (médias + SW + no-404)
- **Médias restaurés**: `bg-luxeevents.png`, `logo_gold_black.png`, galerie `thumb1..8.png`.
- **No-404**: suppression des `<link rel="preload">` orphelins, réécritures/chemins corrigés.
- **SW**: protection contre les erreurs d’enregistrement quand `/sw.js` est absent.
- **CI/CD**: règle de protection **main** = **Vercel** seul requis; **Cloudflare Pages** laissé informatif.
- **Ops**: purge Cloudflare + **smoke tests** 200 sur assets clés.

## [v2.5.1] — 2025-08-23
- Fix `ServicesSection` + ajustements preload/antialiasing sur `index.html` (PR #6).

---

### Notes
- Les checks **Cloudflare Pages** peuvent rester en **failure** (non bloquant). Seul **Vercel** conditionne les merges.
- En cas de régression, rollback via tag (cf. `DEPLOY.md`).
MD

# DEPLOY.md (procédure détaillée)
cat > DEPLOY.md <<'MD'
# DEPLOY — LuxeEvents (Vercel + Cloudflare)

## 1) Prérequis
- GitHub CLI (`gh`) connecté.
- Accès `push` au repo.
- Vercel connecté au repo GitHub (checks automatiques).
- (Optionnel) Cloudflare API pour purge :
  - `CF_API_TOKEN` (Zone:Cache Purge)
  - `CF_ZONE_ID` de `luxeevents.me`

## 2) Règles de merge
- **Branche protégée**: `main`.
- **Check requis**: **Vercel** (deployment completed).  
  > Les checks **Cloudflare Pages** peuvent être en failure — **non bloquant**.

## 3) Workflow standard
1. Créer une branche depuis `main`.
2. Commit & push → ouvre une **PR**.
3. Attendre **Vercel** ✅ (Preview).
4. Merge **squash** → `main`.
5. Purge Cloudflare (recommandé).
6. **Smoke tests** (200):
   - `/`
   - `/bg-luxeevents.png`
   - `/logo_gold_black.png`
   - `/images/gallery/thumb1.png`
7. Tag de version (optionnel mais recommandé).

## 4) Commandes utiles

### Purge Cloudflare (API)
```bash
./cf-purge-now.sh
