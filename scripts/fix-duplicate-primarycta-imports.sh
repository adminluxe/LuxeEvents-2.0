#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_fix_dupe_primarycta_${ts}"
mkdir -p "$BACKUP"

# fichiers ciblés (on peut élargir si besoin)
FILES=(
  "src/components/ServicesSection.jsx"
  "src/components/HeroSection.jsx"
  "src/components/NavBarLuxe.jsx"
  "src/components/NavBar.jsx"
  "src/components/CircularMenu.jsx"
  "src/components/TrustSection.jsx"
  "src/components/GallerySection.jsx"
  "src/components/FooterLuxe.jsx"
)

echo "📦 Backup -> $BACKUP"
for f in "${FILES[@]}"; do
  [ -f "$f" ] || continue
  mkdir -p "$BACKUP/$(dirname "$f")"
  cp -a "$f" "$BACKUP/$f"
done

fix_file() {
  local f="$1"
  [ -f "$f" ] || return 0

  # 1) Si les deux imports existent, supprimer la version .jsx
  if grep -qE 'import[[:space:]]+PrimaryCTA[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA\.jsx["'\''];' "$f" \
     && grep -qE 'import[[:space:]]+PrimaryCTA,[[:space:]]*\{[[:space:]]*DEVIS_ROUTE[[:space:]]*\}[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA["'\''];' "$f"; then
    sed -i '/import[[:space:]]\+PrimaryCTA[[:space:]]\+from[[:space:]]\+["'\'']\.\/PrimaryCTA\.jsx["'\''];/d' "$f"
  fi

  # 2) Si on n'a QUE import PrimaryCTA from "./PrimaryCTA.jsx"; et qu'on utilise DEVIS_ROUTE -> remplacer
  if grep -qE '\bDEVIS_ROUTE\b' "$f" \
     && grep -qE 'import[[:space:]]+PrimaryCTA[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA\.jsx["'\''];' "$f" \
     && ! grep -qE 'from[[:space:]]+["'\'']\./PrimaryCTA["'\''];' "$f"; then
    sed -i 's#import[[:space:]]\+PrimaryCTA[[:space:]]\+from[[:space:]]\+["'\'']\./PrimaryCTA\.jsx["'\''];#import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";#' "$f"
  fi

  # 3) Si on a import PrimaryCTA from "./PrimaryCTA.jsx"; sans DEVIS_ROUTE -> normaliser vers "./PrimaryCTA"
  if grep -qE 'import[[:space:]]+PrimaryCTA[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA\.jsx["'\''];' "$f" \
     && ! grep -qE '\bDEVIS_ROUTE\b' "$f"; then
    sed -i 's#import[[:space:]]\+PrimaryCTA[[:space:]]\+from[[:space:]]\+["'\'']\./PrimaryCTA\.jsx["'\''];#import PrimaryCTA from "./PrimaryCTA";#' "$f"
  fi

  # 4) Si on a import PrimaryCTA from "./PrimaryCTA"; et qu'on utilise DEVIS_ROUTE -> upgrader
  if grep -qE '\bDEVIS_ROUTE\b' "$f" \
     && grep -qE 'import[[:space:]]+PrimaryCTA[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA["'\''];' "$f" \
     && ! grep -qE 'import[[:space:]]+PrimaryCTA,[[:space:]]*\{' "$f"; then
    sed -i 's#import[[:space:]]\+PrimaryCTA[[:space:]]\+from[[:space:]]\+["'\'']\./PrimaryCTA["'\''];#import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";#' "$f"
  fi

  # 5) Si on a import PrimaryCTA, { ... } from "./PrimaryCTA"; mais pas DEVIS_ROUTE -> l’ajouter
  if grep -qE 'import[[:space:]]+PrimaryCTA,[[:space:]]*\{[^}]*\}[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA["'\''];' "$f" \
     && grep -qE '\bDEVIS_ROUTE\b' "$f" \
     && ! grep -qE 'import[[:space:]]+PrimaryCTA,[[:space:]]*\{[^}]*DEVIS_ROUTE[^}]*\}[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA["'\''];' "$f"; then
    sed -i 's#\(import[[:space:]]\+PrimaryCTA,[[:space:]]*\{\)#\1 DEVIS_ROUTE,#' "$f"
  fi

  # 6) (optionnel) supprimer imports PrimaryCTA dupliqués identiques (rare) -> garder la 1ère occurrence
  # si deux lignes identiques "import PrimaryCTA..." se répètent
  awk '
    BEGIN{seen=0}
    {
      if ($0 ~ /^import[[:space:]]+PrimaryCTA/ ) {
        if (seen==1 && $0==prev) next
        prev=$0
        seen=1
      }
      print
    }
  ' "$f" > "$f.__tmp__" && mv "$f.__tmp__" "$f"
}

echo "🧼 Fix duplicate PrimaryCTA imports..."
for f in "${FILES[@]}"; do
  fix_file "$f"
done

echo "🧪 Sanity check: duplicated PrimaryCTA import lines"
echo "----"
grep -RIn --exclude-dir=node_modules --exclude-dir=dist --exclude='*.bak*' \
  -E '^import[[:space:]]+PrimaryCTA' src/components \
  | head -n 200 || true
echo "----"

echo "✅ Done. Run: pnpm dev"
