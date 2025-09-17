/**
 * LuxeEvents – SW Register (idempotent)
 * - Exporte par défaut: safeRegisterSW()
 * - S'auto-exécute si le module est chargé (index.html <script type="module">)
 * - Tolère l'absence de /sw.js (n'échoue pas le runtime)
 */

let __luxeSWRegistered = false;

export default function safeRegisterSW() {
  if (__luxeSWRegistered) return;
  __luxeSWRegistered = true;

  if (typeof window === 'undefined') return;
  if (!('serviceWorker' in navigator)) return;

  const boot = () => {
    const swUrl = '/sw.js';
    navigator.serviceWorker.getRegistration().then((reg) => {
      const isSame = !!reg?.active?.scriptURL?.endsWith('/sw.js');
      if (!reg || !isSame) {
        navigator.serviceWorker.register(swUrl).catch((err) => {
          console.warn('[LuxeEvents] SW registration skipped:', err?.message || err);
        });
      }
    });
  };

  if (document.readyState === 'complete') boot();
  else window.addEventListener('load', boot, { once: true });
}

// Auto-run si importé pour side-effects (ex: via index.html)
try { safeRegisterSW(); } catch {}
// Export nommé facultatif
export { safeRegisterSW as registerSW };
