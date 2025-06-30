const { generateSW } = require('workbox-build');

// Ce script génère le service worker selon ton workbox-config.cjs
generateSW(require('./workbox-config.cjs'))
  .then(({ count, size, warnings }) => {
    warnings.forEach(console.warn);
    console.log(`✅ ${count} fichiers pré-cachés, total ${size} octets`);
  })
  .catch(err => console.error('❌ Erreur lors de la génération du SW :', err));
