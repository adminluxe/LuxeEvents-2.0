#!/usr/bin/env bash
set -e
echo ">> Correction de index.html (injection du script et nettoyage placeholders)…"
# Insérer la balise de script module après la div root
sed -i '/<div id="root"><\/div>/a \    <script type="module" src="/src/main.jsx"></script>' public/index.html 2>/dev/null || \
sed -i '/<div id="root"><\/div>/a \    <script type="module" src="/src/main.jsx"></script>' index.html
# Remplacer les %PUBLIC_URL%/ par rien (chemins directs)
sed -i 's/%PUBLIC_URL%\///g' public/index.html 2>/dev/null || sed -i 's/%PUBLIC_URL%\///g' index.html

echo ">> Correction de la configuration Vite…"
# Déterminer le fichier de config Vite
CONFIG_FILE="vite.config.js"
[ -f vite.config.mjs ] && CONFIG_FILE="vite.config.mjs"
# Insérer base: '/' dans la config
sed -i "/defineConfig({/a \ \ base: '\/'," "$CONFIG_FILE"
# Insérer l'alias '@': 'src'
sed -i "/defineConfig({/a \ \ resolve: { alias: { '@': require('path').resolve(__dirname, 'src') } }," "$CONFIG_FILE"

echo ">> Correctif appliqué. Pensez à reconstruire puis déployer le projet."
