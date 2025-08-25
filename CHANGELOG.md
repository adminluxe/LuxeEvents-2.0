# Changelog — LuxeEvents

## [v2.5.3] — 2025-08-25
### Last-mile polish (SEO / Perf / A11Y)
- SEO : `rel=canonical`, `meta description`, `theme-color`, Open Graph (title/description/url/image), Twitter Card.
- Perf : `preconnect` Google Fonts, preload du visuel héro `bg-luxeevents.png` (meilleur LCP).
- Galerie : `loading="lazy"` + `decoding="async"` sur les vignettes (coût initial + CLS réduits).
- Structured Data : JSON-LD Organization + WebSite.
- Robots / Sitemap : ajout de `robots.txt` et `sitemap.xml`.
- PWA safe : garde d’enregistrement SW (on ne `register` que si `/sw.js` existe en 200).
- CI/CD : livraison via PR (#15) avec check requis Vercel (Cloudflare Pages non bloquant).

## [v2.5.2] — 2025-08-24
### Hotfix prod (médias + SW + no-404)
- Médias restaurés : `bg-luxeevents.png`, `logo_gold_black.png`, galerie `thumb1..8.png`.
- No-404 : suppression des `<link rel="preload">` orphelins, réécritures/chemins corrigés.
- SW : protection contre les erreurs d’enregistrement quand `/sw.js` est absent.
- CI/CD : branche protégée `main` = Vercel seul requis ; Cloudflare Pages laissé informatif.
- Ops : purge Cloudflare + smoke tests (200) sur `/`, `bg-luxeevents.png`, `logo_gold_black.png`, `thumb1.png`.

## [v2.5.1] — 2025-08-23
- Fix `ServicesSection` + ajustements preload/antialiasing sur `index.html` (PR #6).
