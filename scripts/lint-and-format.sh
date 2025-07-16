#!/bin/bash
echo "🧹 Lint & Prettier - Formatage en cours..."

# Lint et correction auto
npx eslint src --fix

# Formatage Prettier
npx prettier . --write

echo "✅ Code formaté et vérifié avec succès. Tonton peut dormir tranquille 😎"
