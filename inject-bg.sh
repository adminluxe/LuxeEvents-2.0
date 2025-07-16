#!/bin/bash

echo "🌄 Injection du fond dynamique dans HeroSection.jsx..."

TARGET="src/components/HeroSection.jsx"

# On ajoute un fond full-screen fixe juste sous la balise <section
sed -i '/<section/,/<\/section>/ {
  /<section/ a\
    <div className="absolute inset-0 -z-10 bg-cover bg-center opacity-20 dark:opacity-10"\
         style={{ backgroundImage: "url('/media/background.png')" }}></div>
}' "$TARGET"

echo "✅ Fond dynamique intégré dans $TARGET"
