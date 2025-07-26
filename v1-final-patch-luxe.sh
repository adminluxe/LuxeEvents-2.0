#!/bin/bash

echo "🚀 [LuxeEvents] Déploiement du patch final V1 – style luxe, fadeIn, HeroSection CSS..."

CSS_FILE="src/components/HeroSection.css"
JSX_FILE="src/components/HeroSection.jsx"
TAILWIND_FILE="tailwind.config.js"

### 1. Créer HeroSection.css si manquant
if [[ ! -f "$CSS_FILE" ]]; then
  echo "🎨 Création de HeroSection.css..."

  cat <<'CSS' > "$CSS_FILE"
/* HeroSection.css - Luxe & Élégance */

.hero-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #0e0c0c;
  padding: 2rem;
  text-align: center;
}

.hero-title {
  font-size: 3rem;
  font-weight: bold;
  color: #f8e9c8;
  text-shadow: 2px 2px 4px #000;
}

.hero-subtitle {
  font-size: 1.5rem;
  margin-top: 1rem;
  color: #fff8dc;
  text-shadow: 1px 1px 3px #000;
}

.hero-button {
  margin-top: 2rem;
  padding: 1rem 2rem;
  background-color: transparent;
  border: 2px solid #f8e9c8;
  color: #f8e9c8;
  border-radius: 9999px;
  font-weight: 600;
  transition: all 0.3s ease-in-out;
  text-shadow: 1px 1px 2px #000;
}

.hero-button:hover {
  background-color: #f8e9c8;
  color: #0e0c0c;
  box-shadow: 0 0 12px #f8e9c8;
}
CSS

  echo "✅ HeroSection.css généré."
else
  echo "✅ HeroSection.css déjà présent."
fi

### 2. Ajouter import CSS si manquant
if ! grep -q "import './HeroSection.css'" "$JSX_FILE"; then
  echo "➕ Ajout de l'import './HeroSection.css' dans HeroSection.jsx..."
  sed -i "1s;^;import './HeroSection.css';\n;" "$JSX_FILE"
else
  echo "✅ Import déjà présent."
fi

### 3. Créer ou patcher tailwind.config.js
if [[ ! -f "$TAILWIND_FILE" ]]; then
  echo "🛠️ Création de tailwind.config.js..."

  cat <<'TAILWIND' > "$TAILWIND_FILE"
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
      animation: {
        fadeIn: "fadeIn 1.2s ease-in-out forwards"
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: "0", transform: "translateY(20px)" },
          "100%": { opacity: "1", transform: "translateY(0)" }
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography')
  ]
}
TAILWIND

  echo "✅ tailwind.config.js généré."
else
  echo "🎯 tailwind.config.js déjà présent, on injecte fadeIn..."

  if ! grep -q "fadeIn" "$TAILWIND_FILE"; then
    sed -i "/extend: {/a\\
      animation: { fadeIn: 'fadeIn 1.2s ease-in-out forwards' },\\
      keyframes: {\\
        fadeIn: {\\
          '0%': { opacity: '0', transform: 'translateY(20px)' },\\
          '100%': { opacity: '1', transform: 'translateY(0)' }\\
        }\\
      },
" "$TAILWIND_FILE"
    echo "✅ fadeIn injecté."
  else
    echo "✅ fadeIn déjà présent."
  fi
fi

### 4. Patch JSX pour utiliser les classes si manquantes
echo "🔍 Vérification des classes HeroSection.jsx..."

if ! grep -q 'className=.*fadeIn' "$JSX_FILE"; then
  sed -i 's/className="/className="fadeIn /' "$JSX_FILE"
  echo "🎉 Class fadeIn appliquée à la première div JSX."
else
  echo "✅ fadeIn déjà appliqué dans HeroSection.jsx"
fi

if ! grep -q 'className=.*text-gold' "$JSX_FILE"; then
  sed -i 's/className="/className="text-gold /' "$JSX_FILE"
  echo "🎉 Class text-gold appliquée à la première div JSX."
else
  echo "✅ text-gold déjà présent."
fi

echo "✅ [LuxeEvents] Patch complet appliqué avec succès !"
