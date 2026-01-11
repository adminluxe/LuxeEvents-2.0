#!/usr/bin/env bash
set -euo pipefail

# ============================================
#  TONTON LOCK FINAL
#  - HashScroller stable + import/usage
#  - IDs sections uniques (top/services/realisations/temoignages)
#  - purge wrappers HomePage/App
#  - ignore src/components/_archive
#  - backup + build
# ============================================

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}_lock_final"
mkdir -p "$bdir"

say(){ printf "%b\n" "$*"; }
ok(){ say "✅ $*"; }
info(){ say "ℹ️  $*"; }
warn(){ say "⚠️  $*"; }
die(){ say "❌ $*"; exit 1; }

ROOT_ID_TOP="top"
ROOT_ID_SERVICES="services"
ROOT_ID_REALISATIONS="realisations"
ROOT_ID_TEMOIGNAGES="temoignages"

MAIN="src/main.jsx"
INDEXHTML="index.html"
HOMEPAGE="src/pages/HomePage.jsx"
APP="src/App.jsx"
HASHCOMP="src/components/HashScroller.jsx"

backup_if_exists() {
  local f="$1"
  if [ -f "$f" ]; then
    mkdir -p "$bdir/$(dirname "$f")"
    cp -a "$f" "$bdir/$f"
  fi
}

# ---------------------------
# 0) Backups
# ---------------------------
backup_if_exists "$MAIN"
backup_if_exists "$INDEXHTML"
backup_if_exists "$HOMEPAGE"
backup_if_exists "$APP"
backup_if_exists "$HASHCOMP"

# ---------------------------
# 1) HashScroller component (stable)
# ---------------------------
if [ ! -f "$HASHCOMP" ]; then
  info "Création $HASHCOMP"
  cat > "$HASHCOMP" <<'JSX'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/**
 * HashScroller
 * - scroll doux vers l'ID présent dans le hash (#services, #realisations, etc.)
 * - offset configurable (header sticky)
 */
export default function HashScroller({ offset = 120 }) {
  const { hash } = useLocation();

  useEffect(() => {
    if (!hash) return;

    const t = setTimeout(() => {
      const id = hash.replace("#", "");
      const el = document.getElementById(id);
      if (!el) return;

      const nav = document.querySelector("header, nav");
      const headerOffset = nav ? nav.getBoundingClientRect().height + 12 : offset;

      const y = el.getBoundingClientRect().top + window.scrollY - headerOffset;
      window.scrollTo({ top: Math.max(0, y), behavior: "smooth" });
    }, 60);

    return () => clearTimeout(t);
  }, [hash, offset]);

  return null;
}
JSX
  ok "HashScroller créé"
else
  ok "HashScroller existe"
fi

# Normalisation: HashScroll -> HashScroller partout
info "Normalisation: HashScroll -> HashScroller (codebase)"
perl -pi -e 's/\bHashScroll\b/HashScroller/g' "$MAIN" 2>/dev/null || true
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='src/components/_archive' 'HashScroll' src >/dev/null 2>&1 && \
  perl -pi -e 's/\bHashScroll\b/HashScroller/g' $(grep -RIl --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='src/components/_archive' 'HashScroll' src) || true

# Assure import HashScroller dans main.jsx
if ! grep -qE 'import\s+HashScroller\s+from\s+["'\'']\./components/HashScroller(\.jsx)?["'\'']' "$MAIN"; then
  info "Injection import HashScroller dans $MAIN"
  # inject après react-router-dom si présent, sinon en haut
  if grep -q 'react-router-dom' "$MAIN"; then
    perl -0777 -pi -e 's/(from\s+["'\'']react-router-dom["'\'']\s*;\s*\n)/$1import HashScroller from "\.\/components\/HashScroller";\n/s' "$MAIN"
  else
    perl -0777 -pi -e 's/^(import[^\n]+\n)/$1import HashScroller from "\.\/components\/HashScroller";\n/s' "$MAIN"
  fi
  ok "Import injecté"
else
  ok "Import HashScroller déjà présent"
fi

# Assure usage <HashScroller ... /> dans render (avant App)
if ! grep -q '<HashScroller' "$MAIN"; then
  info "Injection usage <HashScroller /> dans $MAIN"
  perl -0777 -pi -e 's/(<BrowserRouter>\s*)/$1\n      <HashScroller offset={120} \/>\n/s' "$MAIN"
  ok "Usage injecté"
else
  ok "Usage <HashScroller /> déjà présent"
fi

# ---------------------------
# 2) Preload warning (optionnel, mais propre)
# ---------------------------
if [ -f "$INDEXHTML" ] && grep -q 'bg-luxeevents\.png' "$INDEXHTML"; then
  info "Nettoyage preload bg-luxeevents.png (si présent)"
  # supprime uniquement la ligne de preload (sans toucher aux autres assets)
  sed -i '/rel="preload".*bg-luxeevents\.png/d' "$INDEXHTML" || true
  ok "Preload bg-luxeevents.png nettoyé"
fi

# ---------------------------
# 3) Verrouillage IDs (STRICT)
#    Règle: 1 seul owner par ID (composant de section)
#    => on purge les wrappers de HomePage + App
# ---------------------------
purge_wrapper_ids() {
  local f="$1"
  [ -f "$f" ] || return 0
  info "Purge wrappers IDs dans $f"
  # Supprime toute ligne qui définit un <div ... id="top|services|realisations|temoignages" .../>
  # (car ces IDs doivent vivre dans les composants de section)
  sed -i -E "/id=\"(${ROOT_ID_TOP}|${ROOT_ID_SERVICES}|${ROOT_ID_REALISATIONS}|${ROOT_ID_TEMOIGNAGES})\"/d" "$f"
}

purge_wrapper_ids "$HOMEPAGE"
purge_wrapper_ids "$APP"
ok "Wrappers HomePage/App purgés (si présents)"

# Assure owners: on laisse les composants gérer leur id
# - HeroSection doit porter id="top"
# - ServicesSection doit porter id="services"
# - RealisationsSection doit porter id="realisations"
# - Testimonials doit porter id="temoignages" (ou son section racine)

ensure_id_on_tag() {
  local file="$1"
  local id="$2"
  [ -f "$file" ] || return 0

  if grep -q "id=\"$id\"" "$file"; then
    ok "Owner OK: $id déjà présent dans $file"
    return 0
  fi

  warn "Owner manquant: id=\"$id\" absent dans $file -> tentative injection"
  # Injection conservative: ajoute id sur la première balise <section ...> ou <div ...> rencontrée
  # (sans casser la structure)
  perl -0777 -pi -e 's/<section\b(?![^>]*\bid=)[^>]*>/<section id="'$id'"$&/s' "$file" 2>/dev/null || true
  if ! grep -q "id=\"$id\"" "$file"; then
    perl -0777 -pi -e 's/<div\b(?![^>]*\bid=)[^>]*>/<div id="'$id'"$&/s' "$file" 2>/dev/null || true
  fi

  if grep -q "id=\"$id\"" "$file"; then
    ok "Injection OK: id=\"$id\" ajouté à $file"
  else
    warn "Injection impossible automatiquement pour $file (à faire à la main si nécessaire)"
  fi
}

ensure_id_on_tag "src/components/HeroSection.jsx" "$ROOT_ID_TOP"
ensure_id_on_tag "src/components/ServicesSection.jsx" "$ROOT_ID_SERVICES"
ensure_id_on_tag "src/components/RealisationsSection.jsx" "$ROOT_ID_REALISATIONS"
# selon ton code ça peut être src/components/Testimonials.jsx ou src/components/TestimonialsSection.jsx ou Testimonials.jsx
if [ -f "src/components/Testimonials.jsx" ]; then
  ensure_id_on_tag "src/components/Testimonials.jsx" "$ROOT_ID_TEMOIGNAGES"
elif [ -f "src/components/TestimonialsSection.jsx" ]; then
  ensure_id_on_tag "src/components/TestimonialsSection.jsx" "$ROOT_ID_TEMOIGNAGES"
elif [ -f "src/components/TestimonialsSection.tsx" ]; then
  ensure_id_on_tag "src/components/TestimonialsSection.tsx" "$ROOT_ID_TEMOIGNAGES"
else
  # fallback: ton fichier actuel s'appelle Testimonials.jsx d'après tes logs précédents
  if [ -f "src/components/Testimonials.jsx" ]; then
    ensure_id_on_tag "src/components/Testimonials.jsx" "$ROOT_ID_TEMOIGNAGES"
  else
    warn "Owner temoignages: fichier Testimonials* introuvable (skip)"
  fi
fi

# ---------------------------
# 4) Check strict unicité (en ignorant _archive)
# ---------------------------
count_id() {
  local id="$1"
  grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='src/components/_archive' "id=\"$id\"" src | wc -l | tr -d ' '
}

check_one() {
  local id="$1"
  local c
  c="$(count_id "$id")"
  info "ID \"$id\" count = $c"
  if [ "$c" != "1" ]; then
    warn "Détails occurrences pour id=\"$id\" :"
    grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='src/components/_archive' "id=\"$id\"" src || true
    die "ID \"$id\" doit exister UNE SEULE FOIS."
  fi
}

info "Check unicité IDs (STRICT, _archive ignoré)"
check_one "$ROOT_ID_TOP"
check_one "$ROOT_ID_SERVICES"
check_one "$ROOT_ID_REALISATIONS"
check_one "$ROOT_ID_TEMOIGNAGES"
ok "Unicité IDs OK"

# ---------------------------
# 5) Build (verrouillage ultime)
# ---------------------------
if node -e 'const p=require("./package.json"); process.exit(p.scripts && p.scripts.build ? 0 : 1)' >/dev/null 2>&1; then
  info "Build dispo -> pnpm -s run build"
  pnpm -s run build
  ok "Build OK"
else
  info "Pas de script build détecté -> skip"
fi

say ""
ok "LOCK FINAL TERMINÉ ✅"
info "Backups: $bdir"
say ""
info "NEXT:"
say "  1) (si Vite tourne) Ctrl + C"
say "  2) pnpm -s run dev"
say "  3) Test:"
say "     http://localhost:5173/#services"
say "     http://localhost:5173/#realisations"
say "     http://localhost:5173/#temoignages"
