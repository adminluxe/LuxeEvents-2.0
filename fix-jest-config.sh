#!/usr/bin/env bash
set -euo pipefail

echo "🛠 Réécriture de jest.config.cjs..."

cat > jest.config.cjs << 'EOL'
module.exports = {
  // pour ne pas planter sur les tests embarqués dans public/locales
  modulePathIgnorePatterns: ['<rootDir>/public/'],

  // désactive les collisions de module
  haste: { throwOnModuleCollision: false },

  // environnement DOM
  testEnvironment: 'jest-environment-jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],

  // transforme JS/TS via Babel
  transform: {
    '^.+\\\\.[jt]sx?$': 'babel-jest'
  },

  // extensions connues
  moduleFileExtensions: ['js','jsx','ts','tsx','json','node'],

  // ne cherche les tests que dans src/**/*.test.*
  testMatch: ['<rootDir>/src/**/*.test.[jt]s?(x)'],

  // alias @ → src et stubs d’assets/styles
  moduleNameMapper: {
    '^@\\/(.*)$': '<rootDir>/src/\\1',
    '\\\\.(css|less|sass|scss)$': 'identity-obj-proxy',
    '\\\\.(png|jpe?g|gif|webp|ico|svg)$': '<rootDir>/__mocks__/fileMock.js'
  }
};
EOL

echo "✅ jest.config.cjs mis à jour !"
