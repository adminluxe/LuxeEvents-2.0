#!/bin/bash

echo "💠 Injection du logo192 optimisé..."

mkdir -p public

cp logo192.png public/logo192.png && \
echo "✅ logo192.png placé dans public/"

echo "♻️ Déploiement Vercel..."
vercel --prod
