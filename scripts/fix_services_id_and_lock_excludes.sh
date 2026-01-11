#!/usr/bin/env bash
set -euo pipefail

APP="src/App.jsx"
LOCK="scripts/tonton_lock_nav_and_hash.sh"

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/$ts"
mkdir -p "$bdir"

echo "==> Backup"
[ -f "$APP" ] && cp -a "$APP" "$bdir/App.jsx.bak"
[ -f "$LOCK" ] && cp -a "$LOCK" "$bdir/tonton_lock_nav_and_hash.sh.bak"
echo "✅ Backup: $bdir"
echo

echo "==> AVANT: occurrences id=\"services\""
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' 'id="services"' src | sed -n '1,80p' || true
echo

# 1) FIX REEL : supprimer id="services" UNIQUEMENT dans App.jsx (wrapper)
if [ -f "$APP" ]; then
  # supprime l'attribut id="services" sur n'importe quel tag dans App.jsx
  # (on garde l'id dans ServicesSection.jsx)
  perl -0777 -i -pe 's/\s+id="services"//g' "$APP"
  echo "✅ App.jsx patché (id=\"services\" retiré du wrapper)"
else
  echo "⚠️ App.jsx introuvable -> skip"
fi

echo
echo "==> APRES: occurrences id=\"services\""
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' 'id="services"' src | sed -n '1,80p' || true
echo

# 2) PATCH LOCK : ignorer src/components/_archive (faux positifs)
if [ -f "$LOCK" ]; then
  if grep -q -- "--exclude-dir='_archive'" "$LOCK"; then
    echo "✅ Lock déjà patché pour exclure _archive"
  else
    # Ajoute --exclude-dir='_archive' à côté de node_modules si présent
    sed -i "s/--exclude-dir='node_modules'/--exclude-dir='node_modules' --exclude-dir='_archive'/g" "$LOCK"
    echo "✅ Lock patché: exclusion de _archive"
  fi
else
  echo "⚠️ Script lock introuvable -> skip"
fi

echo
echo "✅ Terminé. Relance le verrouillage :"
echo "   ./scripts/tonton_lock_nav_and_hash.sh"
