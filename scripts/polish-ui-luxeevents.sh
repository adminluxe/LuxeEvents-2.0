#!/bin/bash

echo "🎨 Polish UI – LuxeEvents"

# ✅ Tailwind typography si utile (sinon ignore)
pnpm add -D @tailwindcss/typography

# 📐 Harmonise les tailles & paddings
find ./src -type f -name "*.jsx" -exec sed -i '' 's/p-[0-9]/p-4/g' {} +

# 🎯 Fix des couleurs trop pâles
grep -rl "#f1f1f1" ./src | xargs sed -i '' 's/#f1f1f1/#f8e9c8/g'

# 🧹 Nettoyage éventuel des classes inutiles
pnpm dlx @unocss/cli -r ./src/**/*.jsx --remove-unused --include 'bg-* text-*'

echo "✅ Polish UI terminé."
