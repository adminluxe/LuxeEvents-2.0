#!/usr/bin/env bash
set -euo pipefail

# Se positionner dans le répertoire du script
BASE_DIR="$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
echo "🔄 Déploiement FRONTEND démarré… (base: $BASE_DIR)"

cd "$BASE_DIR"
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
