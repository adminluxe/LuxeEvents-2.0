#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Installation des dépendances nécessaires..."
pnpm add react-icons react-hook-form react-helmet

echo "🔄 Renommage des fichiers .js en .jsx dans src/components et src/pages..."
find src -type f -name "*.js" | while read -r file; do
  newfile="${file%.js}.jsx"
  if [ ! -e "$newfile" ]; then
    echo "  – Moving $file → $newfile"
    git mv "$file" "$newfile"
  fi
done

echo "🔍 Mise à jour des imports pointant vers .js → .jsx..."
find src -type f -name "*.jsx" -exec sed -i -E   "s#(from ['\"][^'\"]+)\.js(['\"])#\1.jsx\2#g" {} +

echo "➕ Création des stubs composants manquants si nécessaire..."
# DarkModeToggle
if [ ! -f src/components/DarkModeToggle.jsx ]; then
  cat << COMP > src/components/DarkModeToggle.jsx
import { useState, useEffect } from "react";
export default function DarkModeToggle() {
  const [mode, setMode] = useState("light");
  useEffect(() => {
    document.documentElement.classList.toggle("dark", mode==="dark");
  }, [mode]);
  return (
    <button onClick={() => setMode(m=>m==="light"?"dark":"light")}>
      {mode==="light"?"🌞":"🌙"}
    </button>
  );
}
COMP
  git add src/components/DarkModeToggle.jsx
  echo "  – Stub DarkModeToggle.jsx créé"
fi

# Button
if [ ! -f src/components/Button.jsx ]; then
  cat << COMP > src/components/Button.jsx
export default function Button({ children, ...props }) {
  return (
    <button {...props} className="px-4 py-2 bg-blue-600 text-white rounded">
      {children}
    </button>
  );
}
COMP
  git add src/components/Button.jsx
  echo "  – Stub Button.jsx créé"
fi

echo "✂ Suppression des dossiers de backup et du cache Vite..."
rm -rf backup_html_* node_modules/.vite

echo "⚙ Vérification / création de vite.config.js avec alias et extensions..."
if [ ! -f vite.config.js ]; then
  cat << CFG > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: { '@': '/src' },
    extensions: ['.js','.jsx','.ts','.tsx']
  }
})
CFG
  echo "  – vite.config.js créé"
else
  echo "  – vite.config.js existe déjà, pense à vérifier la section resolve.alias et extensions"
fi

echo "✅ Toutes les opérations sont terminées !"
echo "Tu peux maintenant relancer le dev :"
echo "  pnpm run dev"
