/** jest.config.cjs **/
module.exports = {
  // Ne pas descendre dans public/ (tests embarqués)
  modulePathIgnorePatterns: ['<rootDir>/public/'],

  // Désactive les collisions de nom
  haste: { throwOnModuleCollision: false },

  // Environnement jsdom + setup
  testEnvironment: 'jest-environment-jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],

  // Babel-Jest transform pour tous les fichiers js/jsx/ts/tsx
  transform: {
    '^.+\\.[jt]sx?$': 'babel-jest',
  },

  // Extensions qu’on veut tester + importer
  moduleFileExtensions: ['js','jsx','ts','tsx','json','node'],

  // Où chercher les tests
  testMatch: ['<rootDir>/src/**/*.test.[jt]s?(x)'],

  // Aliases et stubs
  moduleNameMapper: {
    '^@\\/(.*)$': '<rootDir>/src/$1',
    // court-circuite react-leaflet
    '^react-leaflet$': '<rootDir>/__mocks__/react-leaflet.js',
    // stub assets & styles
    '\\.(css|less|sass|scss)$': 'identity-obj-proxy',
    '\\.(png|jpe?g|gif|webp|ico|svg)$': '<rootDir>/__mocks__/fileMock.js',
  },
}
