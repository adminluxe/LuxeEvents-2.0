import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(({ mode }) => ({
  plugins: [
    react({
      // Force le runtime JSX moderne (pas besoin de 'import React from "react"')
      jsxRuntime: 'automatic',
      babel: {
        presets: [['@babel/preset-react', { runtime: 'automatic', development: mode !== 'production' }]],
      },
      include: '**/*.{jsx,tsx,js,ts}',
    }),
  ],
  server: {
    port: 5173,
  },
}));
