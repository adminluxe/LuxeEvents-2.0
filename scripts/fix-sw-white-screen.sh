#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

TS="$(date +%Y%m%d-%H%M%S)"
BK="_backup_fix_sw_${TS}"
mkdir -p "$BK"

echo "📦 Backup -> $BK"
cp -v index.html "$BK/index.html.bak" || true
cp -v src/main.jsx "$BK/main.jsx.bak" || true
cp -v src/registerSW.js "$BK/registerSW.js.bak" 2>/dev/null || true

echo "🧼 Rewrite index.html (NO inline SW)"
cat > index.html <<'HTML'
<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>LuxeEvents — Événements haut de gamme</title>
    <meta
      name="description"
      content="LuxeEvents : scénographie, coordination, prestataires premium. Le luxe à la portée de tous — une expérience inoubliable."
    />

    <!-- Assets -->
    <link rel="icon" href="/favicon.ico" />
    <link rel="manifest" href="/manifest.webmanifest" />
    <link rel="preload" as="image" href="/bg-luxeevents.png" />

    <!-- Thème -->
    <script src="/theme-init.js"></script>
  </head>

  <body>
    <!-- H1 SEO/Access (hors écran) + style explicit pour calmer MDN -->
    <div style="position:absolute;left:-9999px;width:1px;height:1px;overflow:hidden">
      <h1 style="font-size:48px;margin:0">
        Le luxe à la portée de tous — Une expérience inoubliable.
      </h1>
      <p style="margin:0">Luxe, Excellence, Innovation.</p>
    </div>

    <div id="root"></div>

    <!-- App -->
    <script type="module" src="/src/main.jsx"></script>

    <!-- Anti-bave (ok en defer) -->
    <script src="/anti-bave.js" defer></script>

    <!-- IMPORTANT : aucun script SW inline ici -->
  </body>
</html>
HTML

echo "🧩 Ensure src/registerSW.js (prod-only)"
cat > src/registerSW.js <<'JS'
export function registerSW() {
  // On n'enregistre le SW qu'en PROD (sinon dev = bugs/cache/écran blanc)
  if (!import.meta.env.PROD) return;
  if (!("serviceWorker" in navigator)) return;

  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .catch((err) => console.error("[SW] register failed:", err));
  });
}
JS

echo "🧱 Rewrite src/main.jsx (Router + Nav + HashScroller + SW guard)"
cat > src/main.jsx <<'JSX'
import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";

import App from "./App.jsx";
import "./index.css";

import NavBarLuxe from "./components/NavBarLuxe.jsx";
import HashScroller from "./components/HashScroller.jsx";
import { registerSW } from "./registerSW.js";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <BrowserRouter>
      {/* Gère les ancres (#services, #faq, etc.) + offset navbar */}
      <HashScroller />
      <NavBarLuxe />
      <App />
    </BrowserRouter>
  </React.StrictMode>
);

// SW uniquement en prod (voir guard)
registerSW();
JSX

echo "✅ Done. Index cleaned + main wired + registerSW safe."
echo "➡️ Next: purge SW navigateur + relance dev."
