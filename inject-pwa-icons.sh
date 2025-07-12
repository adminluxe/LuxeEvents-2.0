#!/usr/bin/env bash
set -euo pipefail
set -x  # active le debug, supprimez cette ligne si inutile

# Dossier source où sont déjà vos logos 192 et 512
SRC_DIR="public/assets/media/logos"

# Vérifie que les fichiers sources existent
for size in 192 512; do
  src="$SRC_DIR/logo${size}.png"
  if [ ! -f "$src" ]; then
    echo "⚠️  Fichier introuvable: $src"
    exit 1
  fi
done

# Supprime les anciennes icônes PWA
rm -f public/pwa-192x192.png public/pwa-512x512.png

# Copie les nouvelles icônes
cp "$SRC_DIR/logo192.png" public/pwa-192x192.png
cp "$SRC_DIR/logo512.png" public/pwa-512x512.png

echo "✅ Icônes PWA injectées :"
ls -lh public/pwa-*.png
