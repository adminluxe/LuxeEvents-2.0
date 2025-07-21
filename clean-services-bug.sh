#!/bin/bash
echo "🧹 Nettoyage casing & artefacts Vite…"

# Supprime tous les résidus
rm -rf node_modules .vite dist

# Corrige le casing dans Git
git rm --cached src/pages/services.jsx 2>/dev/null
git add src/pages/Services.jsx
git commit -m "fix: force correct casing on Services.jsx" || echo "✅ Rien à commit"

# Réinstalle & rebuild proprement
pnpm install
pnpm run build && pnpm run preview
