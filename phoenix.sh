#!/usr/bin/env bash

echo "🧹 Nettoyage"
rm -rf dist

echo "🛠 Mise à jour vite.config.js"
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
export default defineConfig({
  base: '/',
  plugins: [react()]
});
EOF

echo "⚙ Création vercel.json"
# ton vercel.json habituel

echo "📦 Installation"
pnpm install

echo "🔨 Build"
pnpm run build

echo "📦 Preview local"
pnpm run preview & sleep 5 && echo "→ tester http://localhost:4173"

echo "🚀 Déploiement Vercel"
vercel --prod --force
