#!/bin/bash
echo "🚀 Lancement du déploiement LuxeEvents..."

# 1. Vérification du dossier Git
if [ ! -d .git ]; then
  echo "❌ Ce dossier n’est pas un dépôt Git. Abandon."
  exit 1
fi

# 2. Création commit vide si aucun changement
git diff --quiet && git diff --cached --quiet
if [ $? -eq 0 ]; then
  echo "ℹ️ Aucun changement détecté. Commit vide pour redeploy..."
  git commit --allow-empty -m "🚀 Redeploy trigger"
else
  echo "✅ Changements détectés : commit en cours..."
  git add .
  git commit -m "🚀 Déploiement automatique LuxeEvents $(date '+%Y-%m-%d %H:%M')"
fi

# 3. Push
echo "📤 Push vers main..."
git push origin main

# 4. Affichage lien Vercel
echo ""
echo "🌐 Vérifie le build en cours sur :"
echo "🔗 https://vercel.com/adminluxes-projects/luxeevents-v3-clean"
echo "🔗 Domaine live : https://luxeevents.me"
