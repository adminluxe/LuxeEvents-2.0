// eslint.config.js
import js from "@eslint/js";

export default [
  { ignores: ["backup*/**","**/backup*/**","**/*.bak.*","**/vercel.json.bak.*"] },
  js.configs.recommended,
];
