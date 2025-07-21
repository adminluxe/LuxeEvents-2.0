const reactPlugin = require("eslint-plugin-react");
const jsxA11yPlugin = require("eslint-plugin-jsx-a11y");
const babelParser = require("@babel/eslint-parser");

module.exports = [
  {
    files: ["**/*.{js,jsx}"],
    languageOptions: {
      parser: babelParser,
      parserOptions: {
        ecmaVersion: 2020,
        sourceType: "module",
        requireConfigFile: false,
        babelOptions: {
          presets: ["@babel/preset-react"],
        },
      },
    },
    plugins: {
      react: reactPlugin,
      "jsx-a11y": jsxA11yPlugin,
    },
    rules: {
      "no-console": "off",
      "react/prop-types": "off",
      "jsx-a11y/alt-text": "warn",
    },
  },
];
