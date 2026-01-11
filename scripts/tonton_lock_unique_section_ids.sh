#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}_lock_ids"
mkdir -p "$bdir"

say() { echo -e "$*"; }
ok()  { echo -e "✅ $*"; }
warn(){ echo -e "⚠️  $*"; }
die() { echo -e "❌ $*"; exit 1; }

# Owners (1 seul fichier autorisé à garder l'id)
OWNER_TOP="src/components/HeroSection.jsx"
OWNER_SERVICES="src/components/ServicesSection.jsx"
OWNER_REALISATIONS="src/components/RealisationsSection.jsx"
# selon ton projet, ça peut être Testimonials.jsx ou TestimonialsSection.jsx
OWNER_TEMOIGNAGES="src/components/Testimonials.jsx"
if [ ! -f "$OWNER_TEMOIGNAGES" ] && [ -f "src/components/TestimonialsSection.jsx" ]; then
  OWNER_TEMOIGNAGES="src/components/TestimonialsSection.jsx"
fi

EXC=(
  --exclude-dir=node_modules
  --exclude-dir=_backups
  --exclude-dir=dist
  --exclude-dir=.git
  --exclude-dir=src/components/_archive
  --exclude='*.bak*'
)

backup_file() {
  local f="$1"
  [ -f "$f" ] || return 0
  mkdir -p "$bdir/$(dirname "$f")"
  cp -a "$f" "$bdir/$f"
}

# Retire id="X" de tous les fichiers sauf owner
strip_id_everywhere_except() {
  local id="$1"
  local owner="$2"

  # liste des fichiers contenant id="id"
  mapfile -t files < <(grep -RIl "${EXC[@]}" "id=\"${id}\"" src 2>/dev/null || true)

  for f in "${files[@]}"; do
    # on conserve seulement dans owner
    if [ "$f" = "$owner" ]; then
      continue
    fi
    backup_file "$f"
    # retire l'attribut id="..."
    perl -pi -e "s/\\s+id=\"${id}\"//g" "$f"
  done
}

# Si l'owner n'a pas l'id, on injecte une ancre safe (div scroll-mt-24) juste après `return (`
ensure_owner_has_anchor() {
  local id="$1"
  local owner="$2"

  [ -f "$owner" ] || { warn "Owner introuvable pour ${id}: ${owner} (skip)"; return 0; }

  if grep -q "id=\"${id}\"" "$owner"; then
    ok "Owner OK: ${id} déjà présent dans ${owner}"
    return 0
  fi

  backup_file "$owner"
  perl -0777 -pi -e "s/return\\s*\\(\\s*/return (\\n    <div id=\"${id}\" className=\"scroll-mt-24\" \\/>\\n/s" "$owner"
  ok "Anchor injectée: ${id} dans ${owner}"
}

# HomePage : on supprime les ancres <div id="top/services/realisations/temoignages" .../>
purge_homepage_anchors() {
  local hp="src/pages/HomePage.jsx"
  [ -f "$hp" ] || { warn "HomePage introuvable (${hp}) (skip)"; return 0; }
  backup_file "$hp"
  sed -i '/<div[[:space:]]\+id="\(top\|services\|realisations\|temoignages\)"/d' "$hp"
  ok "HomePage: ancres <div id=...> purgées"
}

# App.jsx : on retire les id="services/realisations/temoignages/top" si présents sur wrappers
purge_app_wrappers() {
  local app="src/App.jsx"
  [ -f "$app" ] || { warn "App.jsx introuvable (${app}) (skip)"; return 0; }
  backup_file "$app"
  for id in top services realisations temoignages; do
    perl -pi -e "s/\\s+id=\"${id}\"//g" "$app"
  done
  ok "App.jsx: ids retirés des wrappers (si présents)"
}

report_counts() {
  for id in top services realisations temoignages; do
    local n
    n="$(grep -RIn "${EXC[@]}" "id=\"${id}\"" src 2>/dev/null | wc -l | tr -d ' ')"
    echo " - id=\"${id}\": ${n}"
  done
}

say "\n==> 0) État AVANT"
report_counts

say "\n==> 1) Purge HomePage + App wrappers"
purge_homepage_anchors
purge_app_wrappers

say "\n==> 2) S'assurer que les OWNERS ont l'ancre (si manquante)"
ensure_owner_has_anchor "top" "$OWNER_TOP"
ensure_owner_has_anchor "services" "$OWNER_SERVICES"
ensure_owner_has_anchor "realisations" "$OWNER_REALISATIONS"
ensure_owner_has_anchor "temoignages" "$OWNER_TEMOIGNAGES"

say "\n==> 3) Retirer les IDs partout sauf owners (STRICT)"
strip_id_everywhere_except "top" "$OWNER_TOP"
strip_id_everywhere_except "services" "$OWNER_SERVICES"
strip_id_everywhere_except "realisations" "$OWNER_REALISATIONS"
strip_id_everywhere_except "temoignages" "$OWNER_TEMOIGNAGES"

say "\n==> 4) État APRÈS"
report_counts

# Vérif stricte: doit être 1 partout
fail=0
for id in top services realisations temoignages; do
  n="$(grep -RIn "${EXC[@]}" "id=\"${id}\"" src 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$n" != "1" ]; then
    warn "ID '${id}' doit être UNIQUE. Actuel: ${n}"
    grep -RIn "${EXC[@]}" "id=\"${id}\"" src 2>/dev/null || true
    fail=1
  fi
done

[ "$fail" = "0" ] || die "Unicité pas atteinte. (Voir lignes ci-dessus)"

ok "LOCK IDs OK. Backup: $bdir"

# Build si dispo (verrouillage réel)
if node -e 'const p=require("./package.json"); process.exit(p.scripts&&p.scripts.build?0:1)' >/dev/null 2>&1; then
  say "\n==> 5) build (option verrouillage final)"
  pnpm -s run build
  ok "Build OK"
fi

say "\n➡️  NEXT:"
say "1) Ctrl + C dans le terminal Vite"
say "2) pnpm -s run dev"
say "3) Test: http://localhost:5173/#services  /#realisations  /#temoignages"
