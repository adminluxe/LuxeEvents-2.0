module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:jsx-a11y/recommended',
    'plugin:prettier/recommended',
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: ['react', 'react-hooks', 'jsx-a11y', 'prettier'],
  rules: {
    'react/jsx-no-undef': 'error',
    'prettier/prettier': 'warn',
    'react/react-in-jsx-scope': 'off', // utile si tu utilises React 17+
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
};
