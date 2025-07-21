const eslint = require('eslint');
const { ESLint } = eslint;

module.exports = [
  {
    languageOptions: {
      parser: '@babel/eslint-parser',
      globals: {
        window: 'readonly',
        document: 'readonly',
      },
    },
    plugins: {
      react: require('eslint-plugin-react'),
      'jsx-a11y': require('eslint-plugin-jsx-a11y'),
    },
    extends: [
      'eslint:recommended',
      'plugin:react/recommended',
      'plugin:jsx-a11y/recommended',
    ],
    rules: {
      'react/prop-types': 'off',
      'react/react-in-jsx-scope': 'off',
    },
  },
];
