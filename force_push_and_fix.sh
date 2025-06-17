#!/bin/bash

echo "🔄 Reset & Préparation du frontend Luxeevents..."

# 1. Corriger les imports cassés
echo "🛠️ Correction de l'import d'App dans index.js..."
sed -i "s|import App from './App'|import App from './App.js'|" src/index.js

# 2. Ajouter tous les fichiers (même supprimés)
echo "📦 Ajout de tous les fichiers..."
git add -A

# 3. Commit même si y'a rien à commit (pour forcer)
echo "📝 Commit forcé..."
git commit -m '💥 Force push avec correctif App.js'

# 4. Push en forçant la vérité absolue (sans demander la permission)
echo "🚀 Push vers GitHub (branch main)..."
git push -f origin main

echo "✅ Fait ! Ton repo est synchronisé et prêt pour Vercel."

# Optionnel : afficher l'URL du repo si déjà connu
REPO_URL=$(git remote get-url origin)
echo "🔗 Repo: $REPO_URL"
