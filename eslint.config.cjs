module.exports = {
  languageOptions: {
    parser: '@babel/eslint-parser', // Utilisation du parser pour JSX et TSX
    globals: {
      window: 'readonly', // Définir `window` comme global en lecture seule
      document: 'readonly', // Définir `document` comme global en lecture seule
    },
  },
  plugins: {
    react: require('eslint-plugin-react'),
    'jsx-a11y': require('eslint-plugin-jsx-a11y'),
  },
  baseConfig: {
    // Directement inclure les configurations à étendre
    overrides: [
      {
        files: ['*.jsx', '*.tsx'],
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
    ],
  },
};
