#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Recherche et renommage des fichiers non-ASCII dans public/ et src/assets/…"

# On cherche tout fichier dont le chemin contient un caractère hors de la plage ASCII imprimable
find public src/assets -type f -regex '.*[^ -~]+.*' | while read -r file; do
  # On translittère les accents, on remplace tout caractère non-alphanumérique par un tiret
  new=$(echo "$file" \
    | iconv -f utf-8 -t ascii//translit 2>/dev/null \
    | sed -E 's/[^A-Za-z0-9._\/-]/-/g')
  if [[ "$file" != "$new" ]]; then
    echo " • $file → $new"
    mv "$file" "$new"
  fi
done

echo "🧹 Suppression du cache Vite…"
rm -rf node_modules/.vite

echo "✅ Assets renommés et cache vidé. Relancez : npm run dev -- --host"
