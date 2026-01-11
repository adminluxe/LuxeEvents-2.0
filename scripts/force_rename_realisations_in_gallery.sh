#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

f="src/components/GallerySection.jsx"
if [ ! -f "$f" ]; then
  echo "❌ Introuvable: $f"
  exit 1
fi

cp -a "$f" "$bdir/GallerySection.jsx.bak"

echo "==> Avant (lignes avec id=...)"
grep -nE 'id\s*=\s*["'\'']' "$f" || true
echo

echo "==> Remplacement FORCÉ: id=realisations -> id=gallery"
# couvre: id="realisations" | id='realisations' | id = "realisations"
perl -pi -e 's/\bid\s*=\s*("realisations"|'\'realisations'\'')/id="gallery"/g' "$f"

echo "==> Après (lignes avec id=...)"
grep -nE 'id\s*=\s*["'\'']' "$f" || true
echo

echo "==> Vérif globale (doit rester 1 seule occurrence de id=\"realisations\")"
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' 'id="realisations"' src || true

echo
echo "✅ Done. Backup: $bdir"
