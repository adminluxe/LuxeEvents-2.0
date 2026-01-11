#!/usr/bin/env bash
set -euo pipefail

APP="src/App.jsx"
HOME="src/pages/HomePage.jsx"
TESTS="src/components/Testimonials.jsx"

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/$ts"
mkdir -p "$bdir"

echo "==> Backup"
[ -f "$APP" ]  && cp -a "$APP"  "$bdir/App.jsx.bak"
[ -f "$HOME" ] && cp -a "$HOME" "$bdir/HomePage.jsx.bak"
[ -f "$TESTS" ]&& cp -a "$TESTS" "$bdir/Testimonials.jsx.bak"
echo "✅ Backup: $bdir"
echo

echo "==> AVANT (occurrences id=\"temoignages\")"
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='_archive' 'id="temoignages"' src || true
echo

# 1) HomePage.jsx : supprimer la ligne "marker" id="temoignages" (scroll-mt)
if [ -f "$HOME" ]; then
  sed -i '/id="temoignages"/d' "$HOME"
  echo "✅ HomePage.jsx: marker id=\"temoignages\" supprimé"
fi

# 2) Testimonials.jsx : retirer l'attribut id="temoignages" (si présent)
if [ -f "$TESTS" ]; then
  perl -0777 -i -pe 's/\s+id="temoignages"//g' "$TESTS"
  echo "✅ Testimonials.jsx: id=\"temoignages\" retiré"
fi

# 3) App.jsx : garder id="temoignages" et ajouter scroll-mt-24 sur la section correspondante
if [ -f "$APP" ]; then
  # Ajoute scroll-mt-24 à className si section id="temoignages" existe
  # Cas 1: <section id="temoignages" className="...">
  perl -0777 -i -pe '
    s{(<section\b[^>]*\bid="temoignages"[^>]*\bclassName=")([^"]*)(")}
     {$1 . ($2 =~ /\bscroll-mt-24\b/ ? $2 : ($2." scroll-mt-24")) . $3}gse;
  ' "$APP"

  # Cas 2: <section id="temoignages"> sans className -> on ajoute className="scroll-mt-24"
  perl -0777 -i -pe '
    s{<section(\b[^>]*\bid="temoignages"\b[^>]*)>}
     {<section$1 className="scroll-mt-24">}g
     if $& !~ /className=/;
  ' "$APP" || true

  echo "✅ App.jsx: section id=\"temoignages\" conservée + scroll-mt-24 assuré"
fi

echo
echo "==> APRES (occurrences id=\"temoignages\")"
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='_archive' 'id="temoignages"' src || true
echo

echo "✅ Terminé. Relance le verrouillage :"
echo "   ./scripts/tonton_lock_nav_and_hash.sh"
