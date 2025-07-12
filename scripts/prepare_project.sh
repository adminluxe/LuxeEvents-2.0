#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# 1) Import & organisation des médias
# -----------------------------------------------------------------------------
SRC1="/home/tontoncestcarre/uploads/medias_final"
SRC2="/home/tontoncestcarre/uploads/medias_final_new"
DEST="public/assets/media"

echo "📁 Création des dossiers si besoin…"
mkdir -p "$DEST/events" "$DEST/assets"

echo "🔄 Copie et renommage des médias d'événements…"
count=1
# Boucle sur chaque type de fichier
for file in "$SRC1"/*.{jpg,jpeg,png,mp4,mov}; do
  [ -e "$file" ] || continue
  ext="${file##*.}"
  newname=$(printf "events/event_%03d.%s" "$count" "$ext")
  cp "$file" "$DEST/$newname"
  count=$((count + 1))
done

echo "🔄 Copie des nouveaux médias (favicon, logo, backgrounds)…"
for file in "$SRC2"/*; do
  [ -e "$file" ] || continue
  base="$(basename "$file")"
  cp "$file" "$DEST/assets/$base"
done

# -----------------------------------------------------------------------------
# 1.1) Optimisation des images (JPEG/PNG) – tolérance aux erreurs
# -----------------------------------------------------------------------------
echo "⚙️ Optimisation des images (JPEG/PNG)…"
if command -v npx >/dev/null 2>&1; then
  # on ignore volontairement les erreurs si un binaire manque
  npx imagemin "$DEST/events/"*.{jpg,png,jpeg} --out-dir="$DEST/events" || true
  npx imagemin "$DEST/assets/"*.{jpg,png,jpeg} --out-dir="$DEST/assets" || true
else
  echo "⚠️ imagemin-cli non trouvé, optimisation skipée"
fi

# -----------------------------------------------------------------------------
# 2) Vérification des clés de traduction
# -----------------------------------------------------------------------------
echo "🔍 Vérification des traductions…"
LOCALES_EN="src/i18n/en.json"
LOCALES_FR="src/i18n/fr.json"
missing=false

for prefix in about quote gallery; do
  echo "- Clés '$prefix.*'…"
  # Récupère les clés commençant par "$prefix."
  keys_en=$(jq -r "keys[] | select(startswith(\"$prefix.\"))" "$LOCALES_EN" 2>/dev/null || echo "")
  for key in $keys_en; do
    # Vérifie que chaque clé existe aussi en FR
    if ! grep -q "\"$key\"" "$LOCALES_FR"; then
      echo "  ❌ Clé manquante en FR: $key"
      missing=true
    fi
  done
done

if [ "$missing" = true ]; then
  echo "🚨 Des traductions manquent. Veuillez les ajouter avant de continuer."
  exit 1
else
  echo "✅ Toutes les clés de traduction sont présentes."
fi

# -----------------------------------------------------------------------------
# 3) Lancement du serveur de développement
# -----------------------------------------------------------------------------
echo "🚀 Démarrage du serveur de développement (pnpm run dev)…"
pnpm run dev














































