#!/usr/bin/env bash
set -euo pipefail

pnpm install
pnpm run build

echo "🌍 Déploiement via vercel deploy --prod --local-config vercel.json …"
vercel deploy --prod --local-config vercel.json
