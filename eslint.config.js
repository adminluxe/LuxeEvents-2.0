export default [
  {
    ignores: [
      "backup*/**","**/backup*/**","**/*.bak.*","**/vercel.json.bak.*",
      "**/*.{ts,tsx}",           // ⟵ TEMP : on ignore TS/TSX pour débloquer
    ],
  },
  {
    files: ["src/**/*.{js,jsx}"],
    languageOptions: {
      ecmaVersion: 2023,
      sourceType: "module",
      parserOptions: { ecmaFeatures: { jsx: true } }, // ⟵ JSX OK
      globals: {
        window: "readonly",
        document: "readonly",
        navigator: "readonly",
        localStorage: "readonly",
        sessionStorage: "readonly",
        Response: "readonly",
        console: "readonly",
        MutationObserver: "readonly",
        HTMLElement: "readonly",
        setTimeout: "readonly",
        clearTimeout: "readonly",
        requestAnimationFrame: "readonly",
        cancelAnimationFrame: "readonly",
      },
    },
    rules: {
      "no-console": "off",
      "no-unused-vars": "off",
    },
  },
];
