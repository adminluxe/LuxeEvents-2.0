#!/usr/bin/env bash

echo "💫 Installation des dépendances de dev…"
npm install -D vite-plugin-pwa @vitejs/plugin-react tailwindcss postcss autoprefixer

echo "🔧 Génération des fichiers de config…"

# 1) vite.config.js
cat << 'EOF' > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'LuxeEvents',
        short_name: 'LuxeEv',
        start_url: '/',
        display: 'standalone',
        background_color: '#FDF9F3',
        theme_color: '#D4AF37',
        icons: [
          { src: '/favicon-192.png', sizes: '192x192', type: 'image/png' },
          { src: '/favicon-512.png', sizes: '512x512', type: 'image/png' }
        ]
      },
      workbox: {
        runtimeCaching: [
          {
            urlPattern: /^https:\/\/cdn\.luxeevents\.me\/.*\.(png|jpg|jpeg|webp)$/,
            handler: 'CacheFirst',
            options: {
              cacheName: 'images-cache',
              expiration: {
                maxEntries: 100,
                maxAgeSeconds: 60 * 60 * 24 * 30
              }
            }
          },
          {
            urlPattern: /^https:\/\/api\.luxeevents\.me\/.*$/,
            handler: 'NetworkFirst',
            options: {
              cacheName: 'api-cache',
              networkTimeoutSeconds: 10
            }
          }
        ]
      },
      devOptions: {
        enabled: false,
        navigateFallback: '/offline.html'
      }
    })
  ],
  build: {
    // outDir: 'dist',
  },
  server: {
    host: true,
    port: 5173
  }
})
EOF

# 2) tailwind.config.js
cat << 'EOF' > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './index.html',
    './src/**/*.{js,jsx,ts,tsx,html}'
  ],
  theme: { extend: {} },
  plugins: [],
}
EOF

# 3) postcss.config.js
cat << 'EOF' > postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
EOF

# 4) src/index.css
mkdir -p src
cat << 'EOF' > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
  .hero { @apply pt-12 pb-12; }
  .btn-luxe { @apply tracking-wider; }
}

.hero {
  position: relative;
  background-image: url('/background.png');
  background-size: cover;
  background-position: center;
}
.hero::before {
  content: '';
  position: absolute;
  inset: 0;
  background: rgba(212, 175, 55, 0.3);
  pointer-events: none;
}
@media (max-width: 768px) {
  .hero {
    background-position: top center;
  }
}

/* ── Micro-animations LuxeEvents ───────────────────────────────── */
.btn-luxe:hover {
  box-shadow: 0 4px 14px rgba(212,175,55,0.4);
  transform: translateY(-2px);
  transition: box-shadow 0.3s ease, transform 0.3s ease;
}

.gallery-icon:hover {
  filter: brightness(1.1);
  transition: filter 0.3s ease;
}
EOF

echo "✅ Tout est prêt !"
echo "Pour lancer :"
echo "  npm run dev"
echo "Puis ouvre http://localhost:5173/ et fais un Ctrl+F5"
