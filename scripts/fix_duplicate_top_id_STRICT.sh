#!/usr/bin/env bash
set -euo pipefail

F="src/pages/HomePage.jsx"
[ -f "$F" ] || { echo "❌ Introuvable: $F"; exit 1; }

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/$ts"
mkdir -p "$bdir"
cp -a "$F" "$bdir/HomePage.jsx.bak"

echo "==> Avant (HomePage id=top)"
grep -n 'id="top"' "$F" || true
echo

# SUPPRESSION CHIRURGICALE : uniquement dans HomePage.jsx
# enlève la ligne contenant <div id="top" ... />
sed -i '/<div[[:space:]]\+id="top"\b[^>]*\/>/d' "$F"

echo "==> Après (HomePage id=top)"
grep -n 'id="top"' "$F" || true
echo

# Safety : si encore présent, on force via numéro de ligne (rare)
if grep -q 'id="top"' "$F"; then
  echo "⚠️  id=\"top\" encore présent dans HomePage.jsx -> purge forcée (toute ligne contenant id=\"top\" dans HomePage)"
  sed -i '/id="top"/d' "$F"
fi

echo "✅ OK. Backup: $bdir"
