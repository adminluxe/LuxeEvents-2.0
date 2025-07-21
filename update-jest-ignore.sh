#!/usr/bin/env bash
set -euo pipefail

echo "🛠 Mise à jour de jest.config.cjs pour filtrer public/ et ne matcher que src/**/*.test.*"
sed -i.bak "/moduleFileExtensions/a\\
  modulePathIgnorePatterns: ['<rootDir>/public/'],\\
  testMatch: ['<rootDir>/src/**/*.test.[jt]s?(x)']," jest.config.cjs

echo "✅ Fini ! Relance \`pnpm run test\`."
