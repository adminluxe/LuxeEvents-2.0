import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      injectRegister: null,
      registerType: "autoUpdate",
      workbox: { clientsClaim: true, skipWaiting: true },
      manifest: false
    })
  ],
  build: { outDir: "dist", sourcemap: false }
});
