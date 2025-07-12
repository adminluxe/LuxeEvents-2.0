#!/usr/bin/env bash
set -euo pipefail

# Chemin vers ton logo maître dans media/
MASTER="media/logo-master.png"

# Vérifie que le fichier existe
if [ ! -f "$MASTER" ]; then
  echo "⚠️  Fichier maître introuvable: $MASTER"
  exit 1
fi

# Crée le dossier public s’il n’existe pas
mkdir -p public

# Pour chaque taille, on génère l’icone
for size in 192 512; do
  dest="public/pwa-${size}x${size}.png"
  echo "🖼️  Génération de $dest"
  convert "$MASTER" -resize ${size}x${size} "$dest"
done

echo "✅ Icônes PWA créées dans public/:"
ls -lh public/pwa-*.png
