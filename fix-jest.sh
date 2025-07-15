#!/usr/bin/env bash
set -euo pipefail

echo "🛠 Mise à jour de jest.config.cjs"
cat > jest.config.cjs << 'EOL'
module.exports = {
  testEnvironment: 'jest-environment-jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  transform: {
    '^.+\\.[jt]sx?$': 'babel-jest'
  },
  testPathIgnorePatterns: ['<rootDir>/public/'],
  moduleFileExtensions: ['js','jsx','ts','tsx','json','node']
};
EOL

echo "🛠 Mise à jour de jest.setup.js en CommonJS"
cat > jest.setup.js << 'EOL'
/** @type {import('@testing-library/jest-dom')} */
require('@testing-library/jest-dom');
EOL

echo "✅ Config Jest corrigée ! Lancez maintenant \`pnpm run test\`."
