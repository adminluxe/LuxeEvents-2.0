#!/bin/bash

CSS_FILE="src/components/HeroSection.css"
JSX_FILE="src/components/HeroSection.jsx"

echo "🎩 [LuxeEvents] Début du patch HeroSection.css..."

# Étape 1 : Créer HeroSection.css s'il n'existe pas
if [[ ! -f "$CSS_FILE" ]]; then
  echo "📄 Création du fichier HeroSection.css..."

  cat <<'CSS' > "$CSS_FILE"
/* HeroSection.css - version luxe */

.hero-container {
  @apply relative flex items-center justify-center h-screen bg-black text-gold p-4;
  text-shadow: 1px 1px 2px #000; /* Contour noir */
}

.hero-title {
  font-size: 3rem;
  font-weight: bold;
  color: #f8e9c8;
  text-shadow: 2px 2px 4px #000;
  text-align: center;
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

  echo "✅ Fichier CSS créé avec succès."
else
  echo "✅ HeroSection.css déjà présent."
fi

# Étape 2 : Ajouter l'import s'il est manquant
if ! grep -q "import './HeroSection.css'" "$JSX_FILE"; then
  echo "➕ Ajout de l'import './HeroSection.css' dans $JSX_FILE..."
  sed -i "1s;^;import './HeroSection.css';\n;" "$JSX_FILE"
else
  echo "✅ Import déjà présent dans HeroSection.jsx"
fi

echo "🎉 Patch HeroSection terminé avec succès !"
