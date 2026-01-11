#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/$ts"
mkdir -p "$bdir"

say() { printf "\n\033[1;36m%s\033[0m\n" "$*"; }
ok()  { printf "\033[1;32m✅ %s\033[0m\n" "$*"; }
warn(){ printf "\033[1;33m⚠️  %s\033[0m\n" "$*"; }
bad() { printf "\033[1;31m❌ %s\033[0m\n" "$*"; }

say "1) Vérifs & backups"
main="src/main.jsx"
[ -f "$main" ] || { bad "Introuvable: $main"; exit 1; }
cp -a "$main" "$bdir/main.jsx.bak"
ok "Backup: $bdir/main.jsx.bak"

# index.html Vite: généralement à la racine
idx_candidates=("index.html" "public/index.html")
idx=""
for f in "${idx_candidates[@]}"; do
  if [ -f "$f" ]; then idx="$f"; break; fi
done
if [ -n "$idx" ]; then
  cp -a "$idx" "$bdir/$(basename "$idx").bak"
  ok "Backup: $bdir/$(basename "$idx").bak"
else
  warn "Aucun index.html trouvé (root/public) -> on skip le fix preload"
fi

say "2) Fix radical: HashScroller stable + export default + offset"
hfile="src/components/HashScroller.jsx"
mkdir -p "$(dirname "$hfile")"
if [ -f "$hfile" ]; then
  cp -a "$hfile" "$bdir/HashScroller.jsx.bak"
  ok "Backup: $bdir/HashScroller.jsx.bak"
fi

cat > "$hfile" <<'EOF'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/**
 * HashScroller: scroll smooth vers #id avec offset (navbar).
 * Usage: <HashScroller offset={120} />
 */
export default function HashScroller({ offset = 120 }) {
  const { hash } = useLocation();

  useEffect(() => {
    if (!hash) return;

    const t = setTimeout(() => {
      const id = hash.replace("#", "");
      const el = document.getElementById(id);
      if (!el) return;

      // Si on a une navbar/header, on calcule un offset dynamique (plus fiable)
      const nav = document.querySelector("header, nav");
      const dyn = nav?.getBoundingClientRect?.().height ? (nav.getBoundingClientRect().height + 12) : offset;

      const y = el.getBoundingClientRect().top + window.scrollY - dyn;
      window.scrollTo({ top: Math.max(0, y), behavior: "smooth" });
    }, 50);

    return () => clearTimeout(t);
  }, [hash, offset]);

  return null;
}
EOF
ok "Composant écrit: $hfile"

say "3) Fix main.jsx: import HashScroller + remplacement HashScroll->HashScroller"
# - remplace toute mention HashScroll par HashScroller (sécurité)
# - supprime imports HashScroll/HashScroller existants (évite doublons)
# - injecte l'import correct juste après react-router-dom (ou en haut si absent)
perl -pi -e 's/\bHashScroll\b/HashScroller/g' "$main"

tmp="$(mktemp)"
grep -vE '^\s*import .*HashScroll|^\s*import .*HashScroller' "$main" > "$tmp"
mv "$tmp" "$main"

# Inject import HashScroller
if grep -qE 'from\s+["'\'']react-router-dom["'\'']' "$main"; then
  perl -0777 -pi -e 's/(from\s+["'"'"']react-router-dom["'"'"']\s*;?\s*\n)/$1import HashScroller from ".\/components\/HashScroller";\n/s' "$main"
else
  # fallback: inject après ReactDOM import
  perl -0777 -pi -e 's/(import\s+ReactDOM[^\n]*\n)/$1import HashScroller from ".\/components\/HashScroller";\n/s' "$main"
fi

# Vérifie présence du composant dans le render: si absent, on l'insère juste après <BrowserRouter>
if ! grep -q "<HashScroller" "$main"; then
  warn "Aucune balise <HashScroller .../> trouvée -> injection automatique après <BrowserRouter>"
  perl -0777 -pi -e 's/(<BrowserRouter[^>]*>\s*\n)/$1        <HashScroller offset={120} \/>\n/s' "$main"
fi

ok "main.jsx patché"

say "4) Fix preload warning bg-luxeevents.png (optionnel mais propre)"
if [ -n "$idx" ]; then
  # supprime uniquement les lignes qui contiennent bg-luxeevents.png ET preload
  before="$(grep -n "bg-luxeevents\.png" "$idx" 2>/dev/null || true)"
  if echo "$before" | grep -qi "preload"; then
    tmp="$(mktemp)"
    awk '!(tolower($0) ~ /bg-luxeevents\.png/ && tolower($0) ~ /preload/)' "$idx" > "$tmp"
    mv "$tmp" "$idx"
    ok "Preload bg-luxeevents.png retiré dans $idx"
  else
    warn "Pas de preload bg-luxeevents.png trouvé dans $idx -> rien à faire"
  fi
fi

say "5) Vérifs instant (doit afficher uniquement HashScroller import + usage)"
echo "---- Imports HashScroll/HashScroller dans main.jsx ----"
grep -nE 'import .*HashScroll|import .*HashScroller' "$main" || true
echo "---- Usage HashScroller dans main.jsx ----"
grep -nE '<HashScroller' "$main" || true

say "✅ Terminé. Backup complet dans: $bdir"
echo
echo "➡️ Restart Vite (OBLIGATOIRE) :"
echo "   - Va dans le terminal où Vite tourne"
echo "   - Ctrl + C"
echo "   - pnpm -s run dev"
echo
echo "➡️ Test direct :"
echo "   http://localhost:5173/#services"
echo "   http://localhost:5173/#realisations"
echo "   http://localhost:5173/#temoignages"
