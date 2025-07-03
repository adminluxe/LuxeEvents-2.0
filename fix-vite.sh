#!/usr/bin/env bash
set -euo pipefail

echo "🛠️  Fix Vite et purge locales…"

# 1) Supprimer tout le dossier public/locales
rm -rf public/locales
echo " • public/locales supprimé"

# 2) Nettoyer vite.config.js des doublons "server"
#    On extrait d'abord la seule ligne hmr.overlay, puis on recrée le bloc unique.
echo " • Ajustement de vite.config.js"
# Extrait hmr.overlay=false si présent
overlay_line=$(grep -R "overlay: false" vite.config.js || true)
# Supprime tous les blocs server
sed -i '/server:/,/},/d' vite.config.js
# Injecte un unique bloc server juste après defineConfig({
if [[ -n "$overlay_line" ]]; then
  sed -i "/defineConfig({/a \  server: { hmr: { overlay: false } }," vite.config.js
else
  sed -i "/defineConfig({/a \  server: { hmr: { overlay: false } }," vite.config.js
fi

# 3) Vider le cache vite
rm -rf node_modules/.vite
echo " • Cache Vite vidé"

echo "✅ Fix terminé. Relance vite :"
echo "   npm run dev -- --host"
