#!/usr/bin/env bash
set -euo pipefail

echo "📦 Installation de Jest et de ses dépendances"
pnpm add -D jest babel-jest @babel/core @babel/preset-env @babel/preset-react @testing-library/react @testing-library/jest-dom

echo "🛠️  Création de babel.config.cjs"
cat > babel.config.cjs << 'EOL'
module.exports = {
  presets: [
    ['@babel/preset-env', { targets: { node: 'current' } }],
    '@babel/preset-react'
  ]
};
EOL

echo "🛠️  Création de jest.config.cjs"
cat > jest.config.cjs << 'EOL'
module.exports = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  transform: {
    '^.+\\\\.[jt]sx?$': 'babel-jest'
  }
};
EOL

echo "🛠️  Création de jest.setup.js"
cat > jest.setup.js << 'EOL'
import '@testing-library/jest-dom';
EOL

echo "✅ Jest est prêt ! Lancez maintenant \`pnpm test\`."
