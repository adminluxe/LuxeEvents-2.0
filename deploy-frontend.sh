#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="\$HOME/purpleorchid/p/web/luxeevents-frontend"
echo "🔄 Déploiement FRONTEND démarré…"

cd "\$BASE_DIR"
git fetch
git reset --hard origin/main

# Env
cp .env.example .env.local || true
ln -sf .env.local .env

# Install & build
npm install
npm run build

# Deploy sur Vercel
npx vercel --cwd . --prod --yes --confirm

echo "✅ FRONTEND déployé en prod"
