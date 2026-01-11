#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

echo "==> (1) Détection du fichier Home (composeur des sections)..."

HOMEFILE="$(
  grep -RIl --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' \
    -E '(<HeroSection)|(<Services)|(<Gallery)|(<Testimonials)|(<Temoignages)' \
    src/pages src/app src/components src/App.jsx 2>/dev/null \
  | head -n 1 || true
)"

if [ -z "${HOMEFILE:-}" ]; then
  echo "ERROR: Impossible de trouver le fichier qui compose la Home (Hero/Services/Gallery/Testimonial)." >&2
  echo "Astuce: lance -> grep -RIn \"<HeroSection\" src | head" >&2
  exit 1
fi

echo "✅ HOMEFILE = $HOMEFILE"
cp -a "$HOMEFILE" "$bdir/$(basename "$HOMEFILE").bak"

echo
echo "==> (2) Neutralisation des IDs dupliqués dans le reste du projet (anti-collision)..."

# On remplace id="services|realisations|temoignages|top" ailleurs par data-anchor="..."
# pour garantir qu'il n'existe QU'UN SEUL ID par ancre (celui qu'on va créer dans HOMEFILE).
# On exclut HOMEFILE pour ne pas casser l'injection.
mapfile -t FILES < <(
  find src -type f \( -name "*.jsx" -o -name "*.js" \) \
    ! -path "*/node_modules/*" ! -path "*/_backups/*" \
    ! -name "*.bak*" \
    2>/dev/null
)

for f in "${FILES[@]}"; do
  [ "$f" = "$HOMEFILE" ] && continue
  # backup ciblé si fichier contient un id concerné
  if grep -Eq 'id="(top|services|realisations|temoignages)"' "$f"; then
    mkdir -p "$bdir/neutralized"
    cp -a "$f" "$bdir/neutralized/$(echo "$f" | tr '/' '_').bak"
    sed -i \
      -e 's/\bid="top"\b/data-anchor="top"/g' \
      -e 's/\bid="services"\b/data-anchor="services"/g' \
      -e 's/\bid="realisations"\b/data-anchor="realisations"/g' \
      -e 's/\bid="temoignages"\b/data-anchor="temoignages"/g' \
      "$f"
  fi
done

echo "✅ Neutralisation terminée."

echo
echo "==> (3) Injection d'ancres invisibles + scroll-mt dans HOMEFILE (fiable 100%)..."

# Helpers: injecter un <div id="X" className="scroll-mt-24" /> juste AVANT le composant cible
inject_anchor_before() {
  local id="$1"
  local needle="$2"
  local file="$3"

  # si ancre déjà présente, skip
  if grep -Eq "<div[^>]*id=[\"']${id}[\"']" "$file"; then
    echo "✅ Ancre id=\"$id\" déjà présente dans $file"
    return 0
  fi

  # injecte avant la 1ère occurrence de <Needle
  # Compatible JSX: on ajoute une ligne juste avant.
  sed -i "0,/<${needle}\\b/{s/<${needle}\\b/<div id=\"${id}\" className=\"scroll-mt-24\" \\/>\\n      <${needle}/}" "$file"
  echo "✅ Ancre id=\"$id\" injectée avant <$needle> dans $file"
}

# On tente plusieurs noms possibles de composants.
# TOP: on force une ancre tout en haut du layout (avant le 1er return JSX si possible),
# sinon on la met avant Hero.
if ! grep -Eq "<div[^>]*id=[\"']top[\"']" "$HOMEFILE"; then
  # tente avant HeroSection
  if grep -q "<HeroSection" "$HOMEFILE"; then
    inject_anchor_before "top" "HeroSection" "$HOMEFILE"
  else
    # fallback: met en tête du JSX (avant la première balise ouvrante après return)
    sed -i '0,/return[[:space:]]*(/s/return[[:space:]]*(/return (\n    <div id="top" className="scroll-mt-24" \/>/' "$HOMEFILE" || true
    echo "✅ Ancre id=\"top\" injectée (fallback) dans $HOMEFILE"
  fi
fi

# SERVICES
if grep -q "<ServicesSection" "$HOMEFILE"; then
  inject_anchor_before "services" "ServicesSection" "$HOMEFILE"
elif grep -q "<Services" "$HOMEFILE"; then
  inject_anchor_before "services" "Services" "$HOMEFILE"
fi

# REALISATIONS (Gallery)
if grep -q "<GallerySection" "$HOMEFILE"; then
  inject_anchor_before "realisations" "GallerySection" "$HOMEFILE"
elif grep -q "<Gallery" "$HOMEFILE"; then
  inject_anchor_before "realisations" "Gallery" "$HOMEFILE"
fi

# TEMOIGNAGES (Testimonials)
if grep -q "<TestimonialsSection" "$HOMEFILE"; then
  inject_anchor_before "temoignages" "TestimonialsSection" "$HOMEFILE"
elif grep -q "<Testimonials" "$HOMEFILE"; then
  inject_anchor_before "temoignages" "Testimonials" "$HOMEFILE"
elif grep -q "<Temoignages" "$HOMEFILE"; then
  inject_anchor_before "temoignages" "Temoignages" "$HOMEFILE"
fi

echo
echo "==> (4) Audit final (doit afficher 1 occurrence par id)..."
for id in top services realisations temoignages; do
  echo "--- id=\"$id\""
  grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' "id=\"$id\"" src | sed -n '1,6p' || true
done

echo
echo "✅ Terminé. Backups: $bdir"
echo "➡️ Redémarre Vite:"
echo "   ctrl+c"
echo "   pnpm -s run dev"
