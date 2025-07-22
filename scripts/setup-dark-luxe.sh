#!/bin/bash

echo '✨ Activation Dark Luxe mode...'

# 1. Ajout dans tailwind.config.js
sed -i "/module.exports = {/a \ \ darkMode: 'class'," tailwind.config.js

# 2. Création du composant Toggle
mkdir -p src/components
cat <<'JSX' > src/components/DarkModeToggle.jsx
import { useEffect, useState } from 'react';
import { Moon, Sun } from 'lucide-react';

export default function DarkModeToggle({ className = '' }) {
  const [dark, setDark] = useState(false);

  useEffect(() => {
    const saved = localStorage.getItem('theme') === 'dark';
    setDark(saved);
    document.documentElement.classList.toggle('dark', saved);
  }, []);

  const toggle = () => {
    const next = !dark;
    setDark(next);
    document.documentElement.classList.toggle('dark', next);
    localStorage.setItem('theme', next ? 'dark' : 'light');
  };

  return (
    <button
      onClick={toggle}
      className={`fixed bottom-5 left-5 z-50 p-2 rounded-full bg-white/20 hover:bg-white/30 dark:bg-black/30 transition ${className}`}
      aria-label=\"Changer le thème\"
    >
      {dark ? <Sun className=\"w-6 h-6 text-yellow-300\" /> : <Moon className=\"w-6 h-6 text-gray-900\" />}
    </button>
  );
}
JSX

echo '🌙 Composant DarkModeToggle.jsx créé.'

# 3. Ajout de styles dark à globals.css (si non fait)
grep -q '@tailwind base;' ./src/styles/globals.css || echo '@tailwind base;' >> ./src/styles/globals.css
grep -q '@tailwind components;' ./src/styles/globals.css || echo '@tailwind components;' >> ./src/styles/globals.css
grep -q '@tailwind utilities;' ./src/styles/globals.css || echo '@tailwind utilities;' >> ./src/styles/globals.css

echo '✅ Dark Mode prêt. Pense à importer <DarkModeToggle /> dans layout.tsx ou App.jsx.'
