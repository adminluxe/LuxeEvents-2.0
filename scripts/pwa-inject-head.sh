#!/bin/bash

echo "🌐 Injection des balises PWA dans index.html..."

INDEX_FILE="index.html"

if grep -q 'rel="manifest"' "$INDEX_FILE"; then
  echo "✅ Balise manifest déjà présente."
else
  sed -i '/<head>/a \  <link rel="manifest" href="/manifest.webmanifest" />' "$INDEX_FILE"
  echo "🔗 Balise manifest ajoutée."
fi

if grep -q 'name="theme-color"' "$INDEX_FILE"; then
  echo "✅ Balise theme-color déjà présente."
else
  sed -i '/<head>/a \  <meta name="theme-color" content="#ffffff" />' "$INDEX_FILE"
  echo "🎨 Balise theme-color ajoutée."
fi

echo "🔁 Rebuild + déploiement Vercel pour activer le tout..."

npm run build && vercel --prod --force

echo "🚀 PWA activée dans le head HTML – prêtes à l'installation manuelle !"
