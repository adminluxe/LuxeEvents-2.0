#!/bin/bash
echo "🧼 Nettoyage complet..."
rm -rf .vercel dist node_modules
pnpm install
pnpm run build
vercel link
vercel --prod --yes --force
