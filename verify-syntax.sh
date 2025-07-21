#!/bin/bash

# Variables de répertoire
SOURCE_DIR="src"
COMPONENTS_DIR="src/components"

# 1. Vérifier la syntaxe avec ESLint
echo "Vérification de la syntaxe avec ESLint..."
npx eslint $SOURCE_DIR --ext .js,.jsx,.ts,.tsx

# Si ESLint échoue, arrêter le processus de push
if [ $? -ne 0 ]; then
  echo "ESLint a trouvé des erreurs de syntaxe. Veuillez les corriger avant de pousser."
  exit 1
fi

# 2. Correction automatique avec Prettier
echo "Correction automatique avec Prettier..."
npx prettier --write "$SOURCE_DIR/**/*.{js,jsx,ts,tsx}"

# 3. Vérification du status git
git diff --exit-code
if [ $? -ne 0 ]; then
  echo "Des fichiers ont été modifiés par Prettier. Veuillez vérifier et commit les modifications."
  exit 1
fi

echo "Aucune erreur détectée, et tout est propre. Prêt pour le commit et le push."
exit 0
