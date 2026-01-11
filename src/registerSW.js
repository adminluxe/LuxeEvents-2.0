export function registerSW() {
  // IMPORTANT: jamais en dev (vite/HMR + cache = écran blanc assuré)
  if (!import.meta.env.PROD) return;

  if (!("serviceWorker" in navigator)) return;

  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .catch((err) => console.error("[SW] register failed:", err));
  });
}
