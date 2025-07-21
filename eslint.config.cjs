import eslint from 'eslint';
const { ESLint } = eslint;

export default [
  {
    languageOptions: {
      parser: '@babel/eslint-parser', // Utilisation du parser pour JSX et TSX
      globals: {
        window: 'readonly', // Définir  comme global en lecture seule
        document: 'readonly', // Définir  comme global en lecture seule
      },
    },
    plugins: {
      react: require('eslint-plugin-react'),  // Plugin React
      'jsx-a11y': require('eslint-plugin-jsx-a11y'),  // Plugin JSX-a11y
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
