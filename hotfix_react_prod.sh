#!/usr/bin/env bash
set -euo pipefail

echo "== Hotfix React prod =="

# Pick config file
CFG="vite.config.mjs"
[ -f "$CFG" ] || CFG="vite.config.js"

# Ensure plugin is installed
if ! pnpm ls @vitejs/plugin-react >/dev/null 2>&1; then
  echo "• Adding @vitejs/plugin-react…"
  pnpm add -D @vitejs/plugin-react
fi

# Create or patch vite config
if [ ! -f "$CFG" ]; then
  echo "• Creating minimal vite.config.mjs…"
  cat > vite.config.mjs <<'CFG'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  esbuild: {
    jsx: 'automatic',
    jsxImportSource: 'react',
    // parachute: keep React in scope if some files reference it
    jsxInject: `import React from 'react'`,
  },
})
CFG
else
  echo "• Patching $CFG…"
  cp -f "$CFG" "$CFG.bak.$(date +%Y%m%d-%H%M%S)"
  node - "$CFG" <<'NODE'
const fs = require('fs');
const file = process.argv[2] || process.argv[1];
let s = fs.readFileSync(file, 'utf8');

// ensure import
if (!s.includes("@vitejs/plugin-react")) {
  s = `import react from '@vitejs/plugin-react'\n` + s;
}

// ensure plugins: [react()]
if (!/plugins\s*:\s*\[.*react\(\).*]/s.test(s)) {
  s = s.replace(/defineConfig\(\s*\{/, m => `${m}\n  plugins: [react()],`);
}

// ensure/patch esbuild block
if (!/esbuild\s*:/s.test(s)) {
  s = s.replace(/defineConfig\(\s*\{/, m => `${m}
  esbuild: {
    jsx: 'automatic',
    jsxImportSource: 'react',
    jsxInject: \`import React from 'react'\`,
  },`);
} else {
  s = s.replace(/esbuild\s*:\s*\{[^}]*\}/s, (blk) => {
    let b = blk;
    if (!/jsx\s*:\s*'automatic'/.test(b)) b = b.replace(/\{/, "{\n    jsx: 'automatic',");
    if (!/jsxImportSource\s*:\s*'react'/.test(b)) b = b.replace(/\{/, "{\n    jsxImportSource: 'react',");
    if (!/jsxInject\s*:/.test(b)) b = b.replace(/\{/, "{\n    jsxInject: `import React from 'react'`,");
    return b;
  });
}

fs.writeFileSync(file, s);
console.log('  Patched', file);
NODE
fi

# Disable Service Worker (avoid stale bundles)
IDX="index.html"
if [ -f "$IDX" ] && grep -q 'serviceWorker.register' "$IDX"; then
  cp -f "$IDX" "$IDX.bak.$(date +%Y%m%d-%H%M%S)"
  sed -i 's/navigator.serviceWorker.register/false&&navigator.serviceWorker.register/' "$IDX"
  echo "• Service Worker disabled (temporary)."
fi

echo "• Building…"
pnpm build

echo "== Done. Now:"
echo "   git add vite.config.* index.html"
echo "   git commit -m \"fix(build): plugin-react + jsxInject + disable SW (temp)\""
echo "   git push origin main"
