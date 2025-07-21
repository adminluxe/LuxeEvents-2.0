#!/usr/bin/env bash
set -euo pipefail

CFG="tailwind.config.js"
[ -f tailwind.config.cjs ] && CFG="tailwind.config.cjs"

echo "🔧 Patch $CFG avec palette LuxeEvents…"

# Si absent, initialiser
if ! grep -q "module\.exports" "$CFG"; then
  cat > "$CFG" <<'TWC'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html','./src/**/*.{js,jsx,ts,tsx}'],
  theme: { extend: {} },
  plugins: [],
}
TWC
  echo "→ $CFG créé de zéro"
fi

# Injection idempotente
if ! grep -q "luxeGold" "$CFG"; then
  sed -i "/extend: *{/a\\
      colors: {\\
        luxeGold: '#D4AF37',\\
        luxeBlack: '#000000',\\
        luxeIvory: '#FFFFF0',\\
      }," "$CFG"
  echo "✅ Palette injectée dans $CFG"
else
  echo "ℹ Palette déjà présente dans $CFG, skip"
fi

echo "💡 Relance ton dev/build : pnpm run dev"
