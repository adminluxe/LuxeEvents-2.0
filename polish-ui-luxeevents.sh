#!/bin/bash

echo "💎 Finition LuxeEvents – Version Scriptale"

# 🎯 Menu circulaire en haut à droite
sed -i 's|bottom-6 right-6|top-6 right-6|' src/components/CircularMenu.jsx

# ✨ Effets de titre raffinés (hover + centrage)
find src/pages src/components -name "*.jsx" -exec sed -i 's|text-2xl|text-3xl sm:text-4xl font-bold text-center text-yellow-600 hover:scale-105 transition-transform duration-500 shadow-md hover:shadow-yellow-300|g' {} +

# 📐 Centrage des paragraphes
find src/pages src/components -name "*.jsx" -exec sed -i 's|text-left|text-center|g' {} +
find src/pages src/components -name "*.jsx" -exec sed -i 's|items-start|items-center|g' {} +

# 🌄 Ajout d’un fond animé (si non déjà présent)
# Suggestion : intégrer dans App.jsx ou HeroSection une <motion.div> full-screen de fond si besoin.

# 🎞️ Responsive pour Lottie
find src -name "*.jsx" -exec sed -i 's|width: 400px|width: 100%, maxWidth: 500px, height: auto|g' {} +

echo "✅ Patch appliqué. Tu peux relancer avec pnpm run build && vercel --prod"
