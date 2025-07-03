#!/usr/bin/env bash
set -euo pipefail

echo "🕵️ Sentinelle en action : suppression de node_modules et fichiers non-ASCII dans public/…"

# 1) Supprime tous les répertoires node_modules sous public/
find public/ -type d -name "node_modules" -prune -exec rm -rf "{}" \; -print

# 2) Supprime tout autre dossier indésirable (ex. dossiers .cache, .vite)
find public/ -type d \( -name ".cache" -o -name ".vite" \) -prune -exec rm -rf "{}" \; -print

# 3) Supprime tous les fichiers contenant un octet non-ASCII
find public/ -type f -print0 \
  | xargs -0 grep -IlP "[\x80-\xFF]" \
  | while read -r file; do
      echo " • Suppression du fichier à caractères non-ASCII : $file"
      rm -f "$file"
    done

# 4) Vide le cache Vite pour repartir à zéro
echo "🧹 Suppression du cache Vite…"
rm -rf node_modules/.vite

echo "✅ Mission accomplie ! Ton dossier public/ est clean."
