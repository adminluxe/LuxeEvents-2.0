#!/usr/bin/env bash
set -euo pipefail

mkdir -p public

if [[ -f public/luxeevents-bg-hero.webp ]]; then
  echo "✓ Hero déjà présent: public/luxeevents-bg-hero.webp"
  exit 0
fi

# Essaye de trouver un .webp existant dans le repo (léger) pour servir de hero temporaire
CANDIDATE="$(git ls-files '*.{webp,WEBP}' 2>/dev/null | head -n1 || true)"
if [[ -n "${CANDIDATE:-}" && -f "$CANDIDATE" ]]; then
  cp -f "$CANDIDATE" public/luxeevents-bg-hero.webp
  echo "✓ Copié: $CANDIDATE -> public/luxeevents-bg-hero.webp"
else
  echo "⚠ Aucun .webp trouvé à copier."
  echo "  Options:"
  echo "   - Mets un hero réel dans public/luxeevents-bg-hero.webp"
  echo "   - OU commente le <link rel=\"preload\" ...luxeevents-bg-hero.webp> et garde un fond dégradé"
fi

echo "→ Commit & push"
git add public/luxeevents-bg-hero.webp 2>/dev/null || true
git commit -m "chore(hero): add temporary webp hero to avoid 404" || true
git push
