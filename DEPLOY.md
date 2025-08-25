# DEPLOY — LuxeEvents (Vercel + Cloudflare)

## 1) Prérequis
- GitHub CLI (`gh`) connecté.
- Accès `push` au repo.
- Vercel relié au repo GitHub (checks automatiques).
- (Optionnel) Cloudflare API : `CF_API_TOKEN`, `CF_ZONE_ID` de `luxeevents.me`.

## 2) Règles de merge
- Branche protégée : `main`.
- Check requis : **Vercel** (Deployment has completed).
  > Les checks **Cloudflare Pages** peuvent rester en failure — non bloquant.

## 3) Workflow standard
1. Créer une branche depuis `main`.
2. Commit & push → PR.
3. Attendre Vercel ✅ (Preview).
4. Merge **squash** → `main`.
5. Purge Cloudflare.
6. Smoke tests (200) :
   - `/`
   - `/bg-luxeevents.png`
   - `/logo_gold_black.png`
   - `/images/gallery/thumb1.png`
7. (Recommandé) Tag de version (ex: `v2.5.3`).

## 4) Commandes utiles
### Purge Cloudflare
./cf-purge-now.sh

### Smoke tests
for U in / /bg-luxeevents.png /logo_gold_black.png /images/gallery/thumb1.png; do
  echo "TEST $U"; curl -I "https://www.luxeevents.me$U" | head -n1
done

### Tagging
git checkout main && git pull --ff-only
git tag -a vX.Y.Z -m "LuxeEvents: description"
git push origin vX.Y.Z

## 5) Rollback
- Rapide via tag (urgence) :
  git checkout main
  git reset --hard v2.5.2
  git push origin main --force-with-lease   # admin only
- Propre via PR :
  `git revert <merge-commit>` → PR → Vercel ✅ → merge.
- Purger Cloudflare puis refaire les smoke tests.

## 6) Bonnes pratiques
- Preload : jamais sur un média absent (404).
- Service Worker : enregistrer seulement si `/sw.js` répond 200.
- Galerie : `loading="lazy"` + `decoding="async"`.
- SEO : canonical, meta description, OG/Twitter, JSON-LD, robots + sitemap.
- Sécurité : éviter les push directs sur `main` → toujours via PR.

## 7) Post-deploy checklist
- [ ] Vercel Production ✅
- [ ] 200 sur assets clés (cf. smoke)
- [ ] Hero visible + CTA “Devis”
- [ ] Mentions & Politique accessibles
- [ ] Partage (Slack/WhatsApp) → titre/OG corrects
- [ ] Tag de version poussé (ex: v2.5.3)

— Luxe • Excellence • Innovation —
