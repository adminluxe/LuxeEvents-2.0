#!/usr/bin/env bash
set -e

echo "🛠️  Configuration manuelle Tailwind/PostCSS…"

# 1) tailwind.config.js
cat << 'EOF' > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx}"
  ],
  theme: {
    extend: {
      boxShadow: {
        'lux-soft': '0 4px 14px rgba(0, 0, 0, 0.1)',
        'lux-glow': '0 0 30px rgba(212, 175, 55, 0.6)',
      },
    },
  },
  plugins: [],
}
EOF

echo "✔️  tailwind.config.js créé"

# 2) postcss.config.js
cat << 'EOF' > postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

echo "✔️  postcss.config.js créé"

# 3) src/index.css (prépare dossier si besoin)
mkdir -p src
cat << 'EOF' > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* === Tes styles perso en-dessous === */

/* Exemple : */
/*
@layer components {
  .btn-luxe {
    @apply inline-block px-6 py-3 bg-gold text-noir font-semibold uppercase rounded-full shadow-lux-soft transition transform;
  }
  // …
}
*/
EOF

echo "✔️  src/index.css prêt avec directives Tailwind"

echo "✅  Terminé ! Relance un build : npm run build"
