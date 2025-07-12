#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Mise à jour de vite.config.js..."
cat > vite.config.js << 'CFG'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
    },
  },
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'LuxeEvents',
        short_name: 'LuxeEvents',
        description: 'Orchestration d’événements élégants et accessibles',
        theme_color: '#ffffff',
        icons: [
          { src: '/pwa-192x192.png', sizes: '192x192', type: 'image/png' },
          { src: '/pwa-512x512.png', sizes: '512x512', type: 'image/png' }
        ]
      }
    })
  ],
  publicDir: 'public',
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    rollupOptions: {
      external: ['workbox-window']
    }
  },
  define: {
    global: 'window',
  },
})
CFG

echo "🔧 Mise à jour de tailwind.config.js..."
cat > tailwind.config.js << 'CFG'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './index.html',
    './src/**/*.{js,jsx,ts,tsx}'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
CFG

echo "📁 Installation des dépendances..."
pnpm add -D tailwindcss postcss autoprefixer vite-plugin-pwa

echo "📦 Mise à jour des configs PostCSS..."
cat > postcss.config.js << 'CFG'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
CFG

echo "✂ Nettoyage et rebuild..."
rm -rf node_modules/.vite dist .cache
pnpm install
pnpm run build

echo "✅ Fix appliqué et build terminée !"
