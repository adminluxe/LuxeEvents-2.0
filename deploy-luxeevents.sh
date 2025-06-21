#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'deploy-luxeevents'. Description à compléter.
set -e

echo "🧼 Nettoyage..."
rm -rf dist node_modules package-lock.json

echo "🌍 Génération langues..."
# (fr.json & en.json déjà en place)

echo "💅 Copie index.html corrigé..."
# index.html déjà mis à jour par toi

echo "🔨 Build Vite..."
npm install --legacy-peer-deps --silent
npm run build

echo "🚀 Deploy sur Vercel..."
vercel deploy --prod --token $VERCEL_TOKEN

echo "✅ Terminé ! Site en ligne 🌍"
