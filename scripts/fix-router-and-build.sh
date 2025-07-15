#!/bin/bash
echo "🛠️  Correction des imports et build"

# Forcer l'import correct (optionnel)
sed -i 's|from .\/pages\/services|from "./pages/Services"|' src/App.jsx 2>/dev/null

# Clean complet
rm -rf node_modules .vite dist

# Réinstall
pnpm install

# Build & Preview
pnpm run build && pnpm run preview
