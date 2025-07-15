#!/bin/bash

echo "🚨 Correction du bug de routing React..."

echo "🧹 Suppression de l'ancien fichier 'services.jsx' si présent..."
rm -f src/pages/services.jsx

echo "🔁 Nettoyage complet : node_modules, .vite, dist..."
rm -rf node_modules .vite dist

echo "📦 Réinstallation des dépendances..."
pnpm install

echo "🛠️ Reconstruction du projet..."
pnpm run build

echo "🚀 Lancement de l'aperçu local (vite preview)..."
pnpm run preview
