#!/usr/bin/env bash
set -euo pipefail

# fix-vite-config.sh — Replace vite.config.js with minimal dev/prod config
# Usage:
#   chmod +x fix-vite-config.sh
#   ./fix-vite-config.sh /path/to/luxeevents-frontend/vite.config.js

CONFIG_PATH="${1:-vite.config.js}"

if [[ ! -f "$CONFIG_PATH" ]]; then
  echo "❌ File not found: $CONFIG_PATH"
  exit 1
fi

cat > "$CONFIG_PATH" << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  publicDir: 'public',
  build: {
    outDir: 'dist',
    emptyOutDir: true
  }
})
EOF

echo "✅ Updated $CONFIG_PATH to default Vite config without root override."
