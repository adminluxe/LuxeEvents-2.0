const babelParser = require('@babel/eslint-parser');
const reactPlugin = require('eslint-plugin-react');
const jsxA11y = require('eslint-plugin-jsx-a11y');
const tsPlugin = require('@typescript-eslint/eslint-plugin');
const tsParser = require('@typescript-eslint/parser');

module.exports = [
  {
    languageOptions: {
      // Utilisation explicite de Babel pour le JavaScript et TypeScript pour .ts et .tsx
      parser: babelParser,  // Choisir Babel pour les fichiers JS/JSX
      ecmaVersion: 2020,  // Version stable d'ECMAScript
      sourceType: 'module', // Utilisation de la syntaxe module (import/export)
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
      // Base React rules
      'react/prop-types': 'off',
      'react/react-in-jsx-scope': 'off',
      'react/jsx-uses-react': 'error',
      'react/jsx-uses-vars': 'error',

      // JSX Accessibility
      'jsx-a11y/alt-text': 'warn',

      // TypeScript specific
      '@typescript-eslint/no-unused-vars': 'warn',

      // Common best practices
      'no-unused-vars': 'warn',
      'no-console': 'off',
      'semi': ['error', 'always'],
      'quotes': ['error', 'single'],
    },
    settings: {
      react: {
        version: 'detect',  // Détecter automatiquement la version de React
      },
    },
  },
];
