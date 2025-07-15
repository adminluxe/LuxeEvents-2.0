#!/usr/bin/env bash
set -euo pipefail
# 1) Remplacer la version de react-leaflet
sed -i \ 's/"react-leaflet":[[:space:]]*"[^"]\+"/"react-leaflet": "^4.1.0"/' \ package.json
# 2) Réinstaller sans blocage lockfile
pnpm install --no-frozen-lockfile
# 3) Relancer le serveur de dev
pnpm run dev
