import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

const isBuild = process.env.npm_lifecycle_event === 'build';

export default defineConfig({
  resolve: { alias: { '@': require('path').resolve(__dirname, 'src') } },
  base: '/',
  css: { url: false },
  plugins: [
    react(),
    !isBuild &&
      VitePWA({
        /* ta config PWA ici */
      }),
  ].filter(Boolean),
});
