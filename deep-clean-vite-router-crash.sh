#!/bin/bash

echo "🧨 Deep Clean du projet pour résoudre le bug de router.js:241"

echo "🚮 Suppression des traces potentielles restantes..."
rm -rf node_modules .vite dist pnpm-lock.yaml package-lock.json yarn.lock

echo "🧹 Nettoyage du cache local de PNPM..."
pnpm store prune

echo "🧼 Nettoyage de tous les fichiers .tsbuildinfo, .map, et anciens fichiers compilés..."
find . -type f \( -name "*.tsbuildinfo" -o -name "*.map" -o -name "*.jsx" -o -name "*.js" \) -exec rm -f {} +

echo "🗂️ Vérification des doublons sensibles à la casse dans /src/pages/"
ls src/pages | sort | uniq -di

echo "📦 Réinstallation des dépendances..."
pnpm install

echo "🛠️ Reconstruction propre du projet..."
pnpm run build

echo "🚀 Lancement du serveur local (vite preview)..."
pnpm run preview
