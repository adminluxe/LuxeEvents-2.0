const reactPlugin = require("eslint-plugin-react");
const jsxA11yPlugin = require("eslint-plugin-jsx-a11y");
const babelParser = require("@babel/eslint-parser");

module.exports = [
  {
    files: ["**/*.{js,jsx}"],
    languageOptions: {
      parser: babelParser, // Utilisation du parser Babel
      parserOptions: {
        ecmaVersion: 2020,
        sourceType: "module",
        requireConfigFile: false,
        babelOptions: {
          presets: [
            "@babel/preset-env",  // Ajout de preset-env pour que Babel fonctionne bien
            "@babel/preset-react"
          ],
        },
      },
    },
    plugins: {
      react: reactPlugin, // Plugin React pour ESLint
      "jsx-a11y": jsxA11yPlugin, // Plugin pour l'accessibilité
    },
    rules: {
      "no-console": "off", // Désactiver la règle no-console
      "react/prop-types": "off", // Désactiver les erreurs liées aux prop-types
      "jsx-a11y/alt-text": "warn", // Avertir sur les images sans alt
    },
  },
];
