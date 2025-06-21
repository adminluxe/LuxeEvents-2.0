#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'deploy_all'. Description à compléter.
set -e

echo "========================================"
echo "🚀 DEPLOY ALL – luxeEvents Frontend Vite"
echo "========================================"

# 1. Nettoyage HTML
echo "1️⃣ clean_html.sh"
./clean_html.sh

# 2. Backup rapide
echo "2️⃣ Backup express"
tar -czf backup-frontend-$(date +%Y%m%d%H%M).tar.gz .

# 3. Nettoyage dépendances & builds
echo "3️⃣ rm -rf node_modules dist"
rm -rf node_modules dist

# 4. Réinstall et build
echo "4️⃣ npm install --legacy-peer-deps"
npm install --legacy-peer-deps
echo "5️⃣ npm run build"
npm run build

# 5. Déploiement sur Vercel
echo "6️⃣ vercel --prod"
vercel --prod

echo "🎉 Déploiement terminé !"
