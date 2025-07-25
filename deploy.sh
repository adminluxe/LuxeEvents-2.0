#!/usr/bin/env bash
set -e

echo "🧹 Nettoyage"
rm -rf dist
rm -f vite.config.js vercel.json

echo "🛠 Création vite.config.js"
cat << 'EOF' > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: { '@': path.resolve(__dirname, './src') }
  },
  build: {
    outDir: 'dist',
    rollupOptions: {
      input: path.resolve(__dirname, 'index.html'),
    }
  }
})
EOF

echo "⚙ Création vercel.json pour SPA React/Vite"
cat << 'EOF' > vercel.json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "cleanUrls": false,
  "rewrites": [
    {
      "source": "/((?!api/).*)",
      "destination": "/index.html"
    }
  ]
}
EOF

echo "📦 Install"
pnpm install

echo "🔨 build"
pnpm run build

echo "🚀 déploie"
vercel --prod --force
