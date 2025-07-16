#!/bin/bash

echo "🔧 Correction du fond dynamique dans HeroSection.jsx..."

TARGET="src/components/HeroSection.jsx"

# Nettoyer toute ancienne injection <div ... background.png>
sed -i '/background\.png/d' "$TARGET"

# Réinjecter proprement après <section ...> avec indentation correcte
sed -i '/<section/ a\
  <div className="absolute inset-0 -z-10 bg-cover bg-center opacity-20 dark:opacity-10"\
       style={{ backgroundImage: "url(/media/background.png)" }}></div>' "$TARGET"

echo "✅ Fond dynamique réinjecté proprement dans $TARGET"
