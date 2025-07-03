const { generateSW } = require('workbox-build');

generateSW({
  globDirectory: 'dist',
  globPatterns: [
    '**/*.{html,js,css,png,jpg,svg}'
  ],
  swDest: 'dist/service-worker.js',
  runtimeCaching: [
    {
      urlPattern: /\.(?:png|jpg|jpeg|svg)$/,
      handler: 'CacheFirst',
      options: { cacheName: 'images-cache' }
    },
    {
      urlPattern: new RegExp('https://api\\.ton-strapi\\.io'),
      handler: 'NetworkFirst',
      options: { cacheName: 'api-cache' }
    }
  ]
}).then(({ count, size }) => {
  console.log(`Generated SW, precached ${count} files, totaling ${size} bytes`);
});
