import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

const isBuild = process.env.npm_lifecycle_event === 'build';

export default defineConfig({
  css: {
    url: false,
    postcss: './postcss.config.js', // Ta config PostCSS
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
        // Ta configuration PWA ici
      }),
  ].filter(Boolean),
  build: {
    rollupOptions: {
      external: [
        'react-helmet',  // Externalisation de react-helmet pour éviter les problèmes
        'react-i18next', // Et d'autres modules si nécessaire
        'i18next'
      ],
    },
  },
});
