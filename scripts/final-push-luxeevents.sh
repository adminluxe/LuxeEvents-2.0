#!/bin/bash

echo "🧼 Nettoyage des anciennes builds..."
rm -rf dist .vite

echo "🎨 Migration Tailwind (si pas déjà local)"
pnpm add -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
sed -i "/module.exports = {/a \ \ darkMode: 'class'," tailwind.config.js

echo "🔧 Compilation du build..."
pnpm run build

echo "🚀 Déploiement Vercel..."
vercel --prod

echo "✨ Fichier final compilé dans ./dist/"
echo "🌐 Vérifie sur : https://luxeevents.me ou l’URL Vercel active"
