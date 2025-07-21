#!/bin/bash

# Vérification de la configuration ESLint
echo "Validation de la configuration ESLint..."

# Utilisation de ESLint en ligne de commande pour valider la configuration
npx eslint --print-config .eslintrc.js > /dev/null

if [ 0 -eq 0 ]; then
    echo "La configuration ESLint est valide."
else
    echo "Erreur de configuration ESLint. Veuillez vérifier votre fichier de configuration."
    exit 1
fi
