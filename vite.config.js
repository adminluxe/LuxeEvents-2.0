import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

const isBuild = process.env.npm_lifecycle_event === 'build'

export default defineConfig({
  css: {
    url: false,
    postcss: './postcss.config.js',
  },
  server: {
    fs: {
      deny: ['mailcow-dockerized'],
    },
  },
  plugins: [
    react(),
    !isBuild &&
      VitePWA({
        // Ta config PWA ici
      }),
  ].filter(Boolean),
  build: {
    rollupOptions: {
      external: ['react-i18next', 'i18next'], // Exclusion de react-i18next et i18next
    },
  },
})
