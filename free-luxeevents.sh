#!/usr/bin/env bash
set -e

echo "🧹 Nettoyage"
rm -rf dist
rm -f vercel.json vite.config.js

echo "🛠️ Création vite.config.js"
cat > vite.config.js <<EOF
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/',
  plugins: [react()],
  build: {
    outDir: 'dist'
  }
})
EOF

echo "⚙️ Création vercel.json"
cat > vercel.json <<EOF
{
  "builds":[
    {"src":"package.json","use":"@vercel/static-build"}
  ],
  "rewrites":[
    {"source":"/*","destination":"/index.html"}
  ],
  "outputDirectory":"dist"
}
EOF

echo "📦 Installation"
pnpm install

echo "🔨 Build Vite"
pnpm run build

echo "🚀 Déploiement Vercel"
vercel --prod --force

echo "✅ Terminé"
