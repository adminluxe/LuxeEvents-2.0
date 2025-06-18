#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "🔭 Positionnement dans le dossier du projet…"
# Ajuste ce chemin si besoin
cd "$(dirname "$0")"

echo "🧹 Suppression des imports react-refresh/runtime…"
for file in src/index.js src/App.js src/pages/Gallery.js; do
  if [ -f "$file" ]; then
    sed -i.bak "/react-refresh\/runtime/d" "$file" \
      && echo "  ✔ Nettoyé $file"
  fi
done

echo "✏️ Correction des imports pour forcer l’extension .js…"
# App import in index.js
sed -i.bak "s|import App from './App';|import App from './App.js';|" src/index.js \
  && echo "  ✔ src/index.js → import App.js"

# Gallery import in App.js
sed -i.bak "s|import Gallery from './pages/Gallery';|import Gallery from './pages/Gallery.js';|" src/App.js \
  && echo "  ✔ src/App.js → import Gallery.js"

echo "📦 Nettoyage des modules et lockfile…"
rm -rf node_modules package-lock.json

echo "📥 Installation des dépendances…"
npm install

echo "🚀 Démarrage du serveur de dev (port 3000)…"
npm start
