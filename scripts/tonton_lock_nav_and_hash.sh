#!/usr/bin/env bash
set -euo pipefail

# =========================
# TONTON LOCK — LuxeEvents
# - Verrouille HashScroller (import + composant)
# - Verrouille ancres (IDs uniques)
# - Fix preload inutile (bg-luxeevents.png)
# - Checks rapides + build si dispo
# =========================

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/$ts"
mkdir -p "$bdir"

die(){ echo -e "\n❌ $*\n" >&2; exit 1; }
info(){ echo -e "ℹ️  $*"; }
ok(){ echo -e "✅ $*"; }

# --- Ensure we are at project root
[ -f package.json ] || die "package.json introuvable. Lance le script à la racine du repo."

backup(){
  local f="$1"
  [ -f "$f" ] || return 0
  cp -a "$f" "$bdir/$(basename "$f").bak"
}

# --- Paths
MAIN="src/main.jsx"
HASH="src/components/HashScroller.jsx"
INDEX="index.html"

[ -f "$MAIN" ] || die "Introuvable: $MAIN"

backup "$MAIN"
[ -f "$HASH" ] && backup "$HASH"
[ -f "$INDEX" ] && backup "$INDEX"

# ============================================================
# 1) HashScroller: composant robuste (si absent) + import
# ============================================================
if [ ! -f "$HASH" ]; then
  info "HashScroller absent → création de $HASH"
  mkdir -p "$(dirname "$HASH")"
  cat > "$HASH" <<'JSX'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/**
 * HashScroller
 * - écoute le hash (#services, #realisations, #temoignages, #top)
 * - scroll smooth avec offset (navbar)
 */
export default function HashScroller({ offset = 120, delay = 60 }) {
  const { hash } = useLocation();

  useEffect(() => {
    if (!hash) return;

    const t = setTimeout(() => {
      const id = hash.replace("#", "");
      const el = document.getElementById(id);
      if (!el) return;

      const y = el.getBoundingClientRect().top + window.scrollY - offset;
      window.scrollTo({ top: Math.max(0, y), behavior: "smooth" });
    }, delay);

    return () => clearTimeout(t);
  }, [hash, offset, delay]);

  return null;
}
JSX
  ok "HashScroller créé"
else
  # Vérifie export default (verrouille)
  if ! grep -qE 'export\s+default\s+function\s+HashScroller' "$HASH"; then
    die "Ton $HASH n'a pas 'export default function HashScroller'. Corrige-le (ou supprime-le et relance ce script)."
  fi
  ok "HashScroller existe et export default OK"
fi

# Remplace anciennes refs HashScroll -> HashScroller (au cas où)
info "Normalisation: HashScroll -> HashScroller (si présent)"
perl -pi -e 's/\bHashScroll\b/HashScroller/g' "$MAIN"

# Force import HashScroller dans main.jsx si absent
if ! grep -qE 'import\s+HashScroller\s+from\s+' "$MAIN"; then
  info "Import HashScroller manquant → injection dans $MAIN"
  # insère après react-router-dom si présent, sinon en tout début
  if grep -qE 'from\s+"react-router-dom"' "$MAIN"; then
    perl -0777 -pi -e 's/(from\s+"react-router-dom".*\n)/$1import HashScroller from "\.\/components\/HashScroller";\n/s' "$MAIN"
  else
    perl -0777 -pi -e 's/^(import[^\n]*\n)/$1import HashScroller from "\.\/components\/HashScroller";\n/s' "$MAIN"
  fi
  ok "Import HashScroller injecté"
else
  ok "Import HashScroller déjà présent"
fi

# Vérifie usage <HashScroller ... /> (sinon on l’injecte juste avant <App ...)
if ! grep -qE '<HashScroller\b' "$MAIN"; then
  info "Usage <HashScroller /> absent → injection avant <App />"
  perl -0777 -pi -e 's/(<BrowserRouter[^>]*>\s*)/$1\n      <HashScroller offset={120} \/>\n/s' "$MAIN" || true
  # fallback : injection avant <App si BrowserRouter non trouvé
  if ! grep -qE '<HashScroller\b' "$MAIN"; then
    perl -0777 -pi -e 's/(<App\b[^>]*\/?>)/<HashScroller offset={120} \/>\n      $1/s' "$MAIN"
  fi
  grep -qE '<HashScroller\b' "$MAIN" && ok "Usage <HashScroller /> injecté" || die "Impossible d'injecter <HashScroller /> automatiquement."
else
  ok "Usage <HashScroller /> présent"
fi

# ============================================================
# 2) Verrouillage des IDs d'ancres: unicité stricte
#    On protège: top, services, realisations, temoignages
# ============================================================
info "Check unicité IDs: top/services/realisations/temoignages"

check_id_unique(){
  local id="$1"
  local n
  n="$(grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_archive' --exclude-dir='_backups' "id=\"$id\"" src | wc -l | tr -d ' ')"
  if [ "$n" -ne 1 ]; then
    echo "---- Occurrences id=\"$id\" ----"
    grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_archive' --exclude-dir='_backups' "id=\"$id\"" src || true
    die "ID '$id' doit exister UNE SEULE FOIS. Actuel: $n"
  fi
}

# Correction ciblée: si GallerySection utilisait id="realisations" par erreur → id="gallery"
# (c'est le bug classique qui casse le scroll et l’onglet actif)
for gf in \
  "src/components/GallerySection.jsx" \
  "src/components/GalleryPreview.jsx" \
  "src/components/Gallery.jsx"
do
  if [ -f "$gf" ] && grep -q 'id="realisations"' "$gf"; then
    info "Fix: $gf avait id=\"realisations\" → id=\"gallery\""
    backup "$gf"
    sed -i 's/id="realisations"/id="gallery"/g' "$gf"
    ok "Renommage gallery OK"
  fi
done

# Maintenant on exige unicité
# (Si ton Home n'a pas l'un de ces ids, adapte la liste — mais chez toi ils existent)
check_id_unique "top"
check_id_unique "services"
check_id_unique "realisations"
check_id_unique "temoignages"
ok "IDs d'ancres verrouillés (unicité OK)"

# ============================================================
# 3) Fix preload inutile bg-luxeevents.png (warning Firefox)
# ============================================================
if [ -f "$INDEX" ] && grep -q 'bg-luxeevents\.png' "$INDEX" && grep -q 'rel="preload"' "$INDEX"; then
  info "Suppression preload bg-luxeevents.png (warning perf)"
  # retire uniquement les lignes preload qui ciblent bg-luxeevents.png
  sed -i '/rel="preload"/{/bg-luxeevents\.png/d;}' "$INDEX"
  ok "Preload bg-luxeevents.png retiré"
else
  ok "Pas de preload bg-luxeevents.png (ou index.html absent) — OK"
fi

# ============================================================
# 4) Check final: main.jsx contient import + usage
# ============================================================
info "Vérif finale (main.jsx) :"
grep -nE 'import\s+HashScroller|<HashScroller' "$MAIN" || true

# ============================================================
# 5) Build si dispo (verrouillage ultime)
# ============================================================
if node -e 'const p=require("./package.json"); process.exit(p.scripts && p.scripts.build ? 0 : 1)' >/dev/null 2>&1; then
  info "Build dispo → lancement pnpm -s run build (ça verrouille vraiment)"
  pnpm -s run build
  ok "Build OK"
else
  info "Pas de script build détecté → skip"
fi

echo
ok "LOCK TERMINÉ ✅"
echo "Backups: $bdir"
echo
echo "➡️  Maintenant (obligatoire) :"
echo "1) Va dans le terminal où Vite tourne → Ctrl + C"
echo "2) Relance : pnpm -s run dev"
echo
echo "➡️  Tests directs :"
echo "http://localhost:5173/#services"
echo "http://localhost:5173/#realisations"
echo "http://localhost:5173/#temoignages"
