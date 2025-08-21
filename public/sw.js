const VERSION = (self.registration?.scope || '') + 'v1.0.0';
const APP_SHELL = [
  '/',
  '/bg-luxeevents.png'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(VERSION).then((cache) => cache.addAll(APP_SHELL)).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== VERSION).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (event) => {
  const req = event.request;
  const url = new URL(req.url);

  // Ne pas mettre en cache les requêtes non-GET
  if (req.method !== 'GET') return;

  // stratégie: stale-while-revalidate pour /assets, /audio, /
  if (url.pathname.startsWith('/assets/') || url.pathname.startsWith('/audio/') || url.pathname === '/') {
    event.respondWith(
      caches.match(req).then((cached) => {
        const fetchPromise = fetch(req).then((res) => {
          const copy = res.clone();
          caches.open(VERSION).then(cache => cache.put(req, copy));
          return res;
        }).catch(() => cached); // offline fallback
        return cached || fetchPromise;
      })
    );
  }
});
