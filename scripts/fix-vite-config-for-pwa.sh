#!/bin/bash

echo "🛠 Patch vite.config.js – Fusion propre avec plugin PWA..."

sed -i "/import react/i import { VitePWA } from 'vite-plugin-pwa'" vite.config.js

sed -i '/plugins: \[/a \ \ \ \ VitePWA({\n      registerType: "autoUpdate",\n      includeAssets: ["favicon.ico", "logo192.png", "logo512.png"],\n      manifest: {\n        name: "LuxeEvents",\n        short_name: "LuxeEvents",\n        description: "Le luxe à la portée de tous!",\n        theme_color: "#ffffff",\n        background_color: "#000000",\n        display: "standalone",\n        start_url: "/",\n        icons: [\n          {\n            src: "logo192.png",\n            sizes: "192x192",\n            type: "image/png"\n          },\n          {\n            src: "logo512.png",\n            sizes: "512x512",\n            type: "image/png"\n          }\n        ]\n      }\n    }),' vite.config.js

echo "🔁 Rebuild + déploiement Vercel final..."
npm run build && vercel --prod --force --yes

echo "✅ Patch appliqué avec succès – PWA activée dans vite.config.js"
