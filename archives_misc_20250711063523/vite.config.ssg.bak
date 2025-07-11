import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  root: 'public',          // <-- ici
  base: '/',               // racine
  plugins: [react()],
  server: { port: 3000 },
  build: {
    outDir: '../dist',     // dossier de sortie relatif à ‘public/’
    emptyOutDir: true
  }
});
