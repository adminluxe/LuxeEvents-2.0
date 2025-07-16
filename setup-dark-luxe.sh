#!/bin/bash

echo "🔧 Création du contexte de thème..."
mkdir -p src/context
cp ThemeContext.jsx src/context/ThemeContext.jsx

echo "✨ Ajout du composant de bascule..."
mkdir -p src/components
cp ThemeToggle.jsx src/components/ThemeToggle.jsx

echo "🌀 Vérification de tailwind.config.js..."
sed -i 's/darkMode: .*/darkMode: "class",/' tailwind.config.js || echo 'darkMode: "class",' >> tailwind.config.js

echo "🧠 Injection dans main.jsx..."
sed -i 's|<React.StrictMode>|<React.StrictMode>\n    <ThemeProvider>|' src/main.jsx
sed -i 's|</App>|</App>\n    </ThemeProvider>|' src/main.jsx
grep -qxF 'import { ThemeProvider } from "@/context/ThemeContext";' src/main.jsx || sed -i '1i import { ThemeProvider } from "@/context/ThemeContext";' src/main.jsx

echo "📄 Ajout dans HomePage.jsx si nécessaire..."
if ! grep -q "ThemeToggle" src/pages/HomePage.jsx; then
  sed -i '/<\/RevealSection>/a\n      <ThemeToggle />' src/pages/HomePage.jsx
  sed -i '1i import ThemeToggle from "@/components/ThemeToggle";' src/pages/HomePage.jsx
fi

echo "✅ Intégration complète du mode Dark Luxe avec transition dorée animée."
