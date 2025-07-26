#!/bin/bash

CONFIG="tailwind.config.js"

echo "🎨 [LuxeEvents] Patch Tailwind pour couleurs luxe et extensions..."

# Si le fichier n'existe pas, on le crée
if [[ ! -f "$CONFIG" ]]; then
  echo "📄 Création de tailwind.config.js..."

  cat <<'TAILWIND' > "$CONFIG"
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        gold: "#f8e9c8",
        ivory: "#fff8dc",
        dark: "#0e0c0c",
      },
      textShadow: {
        default: "1px 1px 2px #000",
      },
      boxShadow: {
        gold: "0 0 12px #f8e9c8",
      },
      animation: {
        fadeIn: "fadeIn 1s ease-in forwards"
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: 0 },
          '100%': { opacity: 1 }
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ],
}
TAILWIND

  echo "✅ Fichier tailwind.config.js créé avec preset luxe."
else
  echo "⚠️ tailwind.config.js existe déjà. Tu peux le patcher manuellement si nécessaire."
fi

echo "🚀 Patch Tailwind terminé."
