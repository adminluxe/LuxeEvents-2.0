#!/bin/bash

echo "🔎 Vérification des fichiers clés..."

missing=0

for file in src/main.jsx src/App.jsx vite.config.js package.json; do
  if [ ! -f "$file" ]; then
    echo "❌ Manquant : $file"
    missing=1
  else
    echo "✅ Présent : $file"
  fi
done

if ! grep -q '"vite"' package.json; then
  echo "❌ 'vite' non trouvé dans package.json"
  missing=1
else
  echo "✅ 'vite' bien déclaré dans package.json"
fi

if [ "$missing" -eq 1 ]; then
  echo "⛔ Fichiers requis manquants ou 'vite' non déclaré. Abandon."
  exit 1
fi

echo "🧹 Suppression des modules et lockfile..."
rm -rf node_modules pnpm-lock.yaml

echo "📦 Réinstallation propre des dépendances..."
pnpm install

echo "🏗️  Build du projet..."
pnpm run build || { echo "❌ Build échoué"; exit 1; }

echo "🚀 Lancement de l'aperçu local..."
pnpm run preview
