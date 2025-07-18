#!/bin/bash

echo "🎨 Insertion de darkMode dans tailwind.config.ts"
sed -i '/^}/i \ \ darkMode: "class",' tailwind.config.ts

echo "📥 Import de DarkModeToggle dans layout.tsx"
sed -i '1i\import DarkModeToggle from "@/components/DarkModeToggle";' src/app/layout.tsx

echo "🧩 Insertion du composant dans <body> layout.tsx"
sed -i '/<body.*>/,/<\/body>/s|</body>|  <DarkModeToggle />\n  </body>|' src/app/layout.tsx

echo "✅ DarkModeToggle injecté avec succès."
