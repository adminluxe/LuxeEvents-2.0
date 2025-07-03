module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    'react-app',
    'plugin:jsx-a11y/recommended'
  ],
  plugins: [
    'jsx-a11y'
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  rules: {
    // Tu pourras ajuster la sévérité ici, par exemple :
    // 'jsx-a11y/alt-text': 'warn',
  },
};
