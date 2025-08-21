#!/usr/bin/env bash
set -euo pipefail

echo "== Fix React runtime (JSX automatique) =="

ROOT_HINT="src"
if [[ ! -d "$ROOT_HINT" ]]; then
  echo "⚠️  Je ne vois pas ./src ici. Lance ce script à la racine du projet."
  exit 1
fi

# 1) Vérif dépendances (au cas où)
need_pkg() {
  if ! pnpm ls --depth -1 "$1" >/dev/null 2>&1; then
    echo "→ Installation manquante: $1"
    pnpm add -D "$1"
  fi
}
need_pkg "@vitejs/plugin-react"
need_pkg "@babel/preset-react"

# 2) Sauvegarde du vite.config existant
CFG="vite.config.mjs"
TS=$(date +"%Y%m%d-%H%M%S")
if [[ -f "$CFG" ]]; then
  cp -f "$CFG" "vite.config.mjs.bak.$TS"
  echo "• Backup: vite.config.mjs.bak.$TS"
fi

# 3) Écrit une config Vite propre avec runtime JSX automatique
cat > "$CFG" <<'VITE'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(({ mode }) => ({
  plugins: [
    react({
      // Force le runtime JSX moderne (pas besoin de 'import React from "react"')
      jsxRuntime: 'automatic',
      babel: {
        presets: [['@babel/preset-react', { runtime: 'automatic', development: mode !== 'production' }]],
      },
      include: '**/*.{jsx,tsx,js,ts}',
    }),
  ],
  server: {
    port: 5173,
  },
}));
VITE

echo "• vite.config.mjs réécrit (JSX automatique ✅)"

# 4) (Optionnel) Plan B : ajout d'imports React si tu veux forcer le classic runtime
# Décommenter pour l'utiliser :
# for f in $(git ls-files '*.jsx' | tr '\n' ' '); do
#   if ! grep -qE '^\s*import\s+React\s+from\s+[\"\']react[\"\']' "$f"; then
#     sed -i '1i import React from "react";' "$f"
#     echo "  ↳ import React ajouté: $f"
#   fi
# done

echo
echo "Tout bon. Relance le serveur:"
echo "  pnpm run dev"
