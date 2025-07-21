import eslint from 'eslint';
const { ESLint } = eslint;

export default {
  languageOptions: {
    parser: '@babel/eslint-parser', // Utiliser le parser @babel/eslint-parser pour JSX/TSX
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
};
