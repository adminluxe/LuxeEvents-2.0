import { defineConfig } from "vite";
export default defineConfig({
  build: {
    target: "es2020",
    sourcemap: false,
    cssCodeSplit: true,
    assetsInlineLimit: 0,
    chunkSizeWarningLimit: 1000,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (!id) return null;
          if (id.includes("node_modules")) {
            if (id.includes("react")) return "react";
            if (id.includes("framer-motion")) return "framer";
            if (id.includes("swiper")) return "swiper";
            return "vendor";
          }
          return null;
        }
      }
    }
  }
});
