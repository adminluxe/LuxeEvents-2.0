#!/bin/bash

# 1. Mettre à jour le fichier eslint.config.js avec la bonne syntaxe ESM
cat <<EOF > eslint.config.js
import eslint from 'eslint';
const { defineConfig } = eslint;

export default defineConfig({
  languageOptions: {
    globals: {
      window: 'readonly',
      document: 'readonly',
    },
  },
  plugins: ['react', 'jsx-a11y'],
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:jsx-a11y/recommended',
  ],
  rules: {
    'react/prop-types': 'off',
    'react/react-in-jsx-scope': 'off',
  },
});
EOF

# 2. Ajouter "type": "module" dans package.json
sed -i '/"dependencies": {/i \  "type": "module",' package.json

echo "Fichiers mis à jour avec succès !"
