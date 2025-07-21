const babelParser = require('@babel/eslint-parser');
const reactPlugin = require('eslint-plugin-react');
const jsxA11y = require('eslint-plugin-jsx-a11y');
const tsPlugin = require('@typescript-eslint/eslint-plugin');
const tsParser = require('@typescript-eslint/parser');

module.exports = [
  {
    languageOptions: {
      // Dynamically choose the parser based on the file extension
      parser: (filename) => {
        if (filename.endsWith('.ts') || filename.endsWith('.tsx')) {
          return tsParser;  // Use TypeScript parser for .ts/.tsx files
        }
        return babelParser;  // Use Babel parser for .js/.jsx files
      },
      ecmaVersion: 2020,  // Use a stable version of ECMAScript
      sourceType: 'module',  // Enable module syntax
      globals: {
        window: 'readonly',
        document: 'readonly',
        console: 'readonly',
        module: 'writable',
        require: 'readonly',
        process: 'readonly',
      },
    },
    plugins: {
      react: reactPlugin,
      'jsx-a11y': jsxA11y,
      '@typescript-eslint': tsPlugin,
    },
    rules: {
      // Désactiver certains avertissements
      'no-console': 'warn', // Changer en 'off' si tu veux désactiver la règle sur les consoles
      'react/prop-types': 'off', // Désactiver cette règle si tu utilises TypeScript (pas besoin de prop-types)
      'jsx-a11y/alt-text': 'warn', // Garder ce genre d'avertissement pour l'accessibilité

      // Ajouter des règles personnalisées
      'no-unused-vars': 'warn',  // Détecter les variables inutilisées
      'no-console': 'off',       // Si tu veux ignorer les erreurs liées aux `console.log`
      'semi': ['error', 'always'], // Toujours utiliser un point-virgule à la fin des instructions
      'quotes': ['error', 'single'], // Utiliser des guillemets simples pour les chaînes de caractères
    },
    settings: {
      react: {
        version: 'detect',  // Détecter la version de React automatiquement
      },
    },
  },
];
