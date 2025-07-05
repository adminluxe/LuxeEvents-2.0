import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  plugins: [
    react(),
    new VitePWA({
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
            options: { cacheName: 'images-cache', expiration: { maxEntries: 100, maxAgeSeconds: 2592000 } }
          },
          {
            urlPattern: /^https:\/\/api\.luxeevents\.me\/.*$/,
            handler: 'NetworkFirst',
            options: { cacheName: 'api-cache', networkTimeoutSeconds: 10 }
          }
        ]
      },
      devOptions: { enabled: false, navigateFallback: '/offline.html' }
    })
  ],
  server: { host: true, port: 5173, strictPort: true }
})
