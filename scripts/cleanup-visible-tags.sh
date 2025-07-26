#!/bin/bash

echo "🧽 Suppression des mentions 'VISIBLE:' résiduelles..."

find ./src -type f -name "*.jsx" -exec sed -i '/VISIBLE:/d' {} +

echo "✅ Mentions 'VISIBLE:' supprimées."

echo "🔁 Rebuild du site..."
npm run build && vercel --prod --force

echo "🎯 Site re-déployé sans les mentions VISIBLE. Luxe purifié !"
