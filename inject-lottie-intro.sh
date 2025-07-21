#!/bin/bash
echo "📦 Injection de l’intro Lottie LuxeEvents..."

mkdir -p ./src/assets

cp ./src/assets/luxeevents-intro.json ./src/assets/luxeevents-intro.json

echo "✅ Fichier Lottie copié dans src/assets/"
echo "🚀 Démarrage de l’app..."
pnpm run dev
