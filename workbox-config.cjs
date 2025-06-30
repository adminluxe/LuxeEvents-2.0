module.exports = {
  globDirectory: 'dist/',
  globPatterns: ['**/*.{html,js,css,png,svg,json}'],
  swDest: 'dist/service-worker.js',
  runtimeCaching: [
    {
      urlPattern: /\/assets\//,
      handler: 'StaleWhileRevalidate',
      options: {
        cacheName: 'assets-cache',
        expiration: { maxEntries: 100, maxAgeSeconds: 2592000 } // 30 jours
      }
    }
  ]
};
