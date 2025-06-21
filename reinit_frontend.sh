#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'reinit_frontend'. Description à compléter.
set -e

echo "=========================================="
echo "🔄 RESET & REBUILD – luxeEvents Frontend"
echo "=========================================="

# 0. Se placer dans la racine du projet
cd "$(dirname "$0")"

# 1. Backup express
BACKUP="luxeevents-frontend-backup-$(date +%Y%m%d%H%M).tar.gz"
echo "📦 Sauvegarde du dossier courant → $BACKUP"
tar -czf "$BACKUP" .

# 2. Nettoyage total des dépendances & builds
echo "🧹 Suppression de node_modules, dist, build, lockfiles…"
rm -rf node_modules package-lock.json yarn.lock dist build

# 3. Réécriture des configs critiques (remplace si tu veux adapter le contenu)  
echo "🛠️  Réécriture de package.json"
cat > package.json <<'EOF'
{
  "name": "luxeevents-frontend",
  "version": "1.0.0",
  "description": "Frontend de LuxeEvents — La plateforme d’événements chic et accessibles",
  "author": "TontonCestCarré",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "6.30.1",
    "i18next": "25.2.1",
    "react-i18next": "15.5.3",
    "styled-components": "6.1.19",
    "date-fns": "4.1.0",
    "framer-motion": "12.18.1",
    "gsap": "3.13.0",
    "yet-another-react-lightbox": "3.23.3"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.2.1",
    "vite": "^4.0.0"
  }
}
EOF

echo "🛠️  Réécriture de vite.config.js"
cat > vite.config.js <<'EOF'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: { port: 3000 },
  build: { outDir: 'dist' }
});
EOF

echo "🛠️  Réécriture de vercel.json"
cat > vercel.json <<'EOF'
{
  "version": 2,
  "builds": [
    { "src": "package.json", "use": "@vercel/static-build" }
  ],
  "routes": [
    { "handle": "filesystem" },
    { "src": "/(.*)", "dest": "/index.html" }
  ]
}
EOF

# 4. Remise en place de la structure Vite (public + src)
echo "⚙️  Vérification de la structure /public et /src"
bash check_structure.sh

# 5. Réinstallation
echo "📥 npm install (--legacy-peer-deps)…"
npm install --legacy-peer-deps

# 6. Build
echo "🏗️  npm run build…"
npm run build

echo "🎉 Build complet → dossier dist/ prêt pour déploiement"
echo "👉 Pousse vers GitHub puis vercel --prod"
