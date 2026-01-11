#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/$ts"
mkdir -p "$bdir"

F="src/pages/HomePage.jsx"
[ -f "$F" ] || { echo "❌ Introuvable: $F"; exit 1; }

cp -a "$F" "$bdir/HomePage.jsx.bak"

echo "==> Avant (lignes id=\"top\")"
grep -n 'id="top"' "$F" || true
echo

# Supprime uniquement la ligne "ancre" inutile
# ex: <div id="top" className="scroll-mt-24" />
perl -ni -e 'print unless /<div\s+id="top"\b[^>]*scroll-mt-24[^>]*\/>/' "$F"

echo "==> Après (lignes id=\"top\")"
grep -n 'id="top"' "$F" || true
echo

echo "✅ Fix appliqué. Backup: $bdir"
