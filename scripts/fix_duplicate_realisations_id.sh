#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

echo "==> Backup des fichiers concernés"
[ -f src/components/GallerySection.jsx ] && cp -a src/components/GallerySection.jsx "$bdir/GallerySection.jsx.bak" || true
[ -f src/components/RealisationsSection.jsx ] && cp -a src/components/RealisationsSection.jsx "$bdir/RealisationsSection.jsx.bak" || true

echo "==> 1) Renomme l'ID du GallerySection pour éviter collision"
if [ -f src/components/GallerySection.jsx ]; then
  sed -i 's/\bid="realisations"\b/id="gallery"/g' src/components/GallerySection.jsx
fi

echo "==> 2) Vérif: il doit rester 1 seule occurrence de id=\"realisations\" (RealisationsSection)"
echo "--- Occurrences id=\"realisations\""
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' 'id="realisations"' src || true

echo
echo "--- Occurrences id=\"gallery\""
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' 'id="gallery"' src | sed -n '1,20p' || true

echo
echo "✅ Done. Backups: $bdir"
echo "➡️ Restart vite:"
echo "   ctrl+c"
echo "   pnpm -s run dev"
