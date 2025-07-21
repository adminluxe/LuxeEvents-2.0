const babelParser = require('@babel/eslint-parser');
const reactPlugin = require('eslint-plugin-react');
const jsxA11y = require('eslint-plugin-jsx-a11y');
const tsPlugin = require('@typescript-eslint/eslint-plugin');
const tsParser = require('@typescript-eslint/parser');

// Custom function to handle the parser logic
const customParser = (filename) => {
  if (filename.endsWith('.ts') || filename.endsWith('.tsx')) {
    return tsParser; // Use TypeScript parser for .ts/.tsx files
  }
  return babelParser; // Use Babel parser for .js/.jsx files
};

module.exports = [
  {
    languageOptions: {
      // Use the custom parser function
      parser: customParser,
      ecmaVersion: 2020, // Use a stable version of ECMAScript for compatibility
      sourceType: 'module', // Enable module syntax
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
        version: 'detect', // Automatically detect the React version
      },
    },
  },
];
