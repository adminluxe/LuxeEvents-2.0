#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TS="$(date +%Y%m%d-%H%M%S)"
BK="_backup_fix_router_nav_sw_${TS}"
mkdir -p "$BK"

echo "📦 Backup => $BK"
cp -v index.html "$BK/index.html.bak" 2>/dev/null || true
cp -v src/main.jsx "$BK/main.jsx.bak" 2>/dev/null || true
cp -v src/App.jsx "$BK/App.jsx.bak" 2>/dev/null || true

echo "🧼 Clean index.html (remove ALL SW inline scripts + SW guard duplicates)"
python3 - <<'PY'
import re, pathlib
p = pathlib.Path("index.html")
s = p.read_text(encoding="utf-8")

# Remove any <script> blocks containing serviceWorker / SW guard / registernavigator
pattern = re.compile(r'(?is)<script\b[^>]*>.*?(serviceWorker|SW guard|registernavigator).*?</script>\s*')
s2 = re.sub(pattern, "", s)

# Safety: if anything like navigator.serviceWorker.register remains in inline scripts, remove those lines too
s2 = re.sub(r'(?im)^\s*.*navigator\.serviceWorker\.register.*\n', "", s2)

p.write_text(s2, encoding="utf-8")
print("OK: index.html cleaned")
PY

echo "🧠 Ensure src/registerSW.js exists (prod-only guard)"
mkdir -p src
cat > src/registerSW.js <<'JS'
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
JS

echo "🧱 Rewrite src/main.jsx (Router + HashScroller + NavBarLuxe + SW prod-only)"
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
      {/* Ancres (#services, #faq, etc.) + offset navbar */}
      <HashScroller />
      {/* Navbar globale (1 seule fois, ici) */}
      <NavBarLuxe />
      {/* App / Routes */}
      <App />
    </BrowserRouter>
  </React.StrictMode>
);

// SW uniquement en prod (guard dans registerSW)
registerSW();
JSX

echo "🧹 Patch src/App.jsx: remove any NavBar/NavBarLuxe tags/imports (avoid double 'Devis')"
python3 - <<'PY'
import re, pathlib
p = pathlib.Path("src/App.jsx")
if not p.exists():
  print("WARN: src/App.jsx not found, skipping")
  raise SystemExit(0)

s = p.read_text(encoding="utf-8")

# Remove imports mentioning NavBar / NavBarLuxe
s = re.sub(r'(?m)^\s*import\s+.*NavBarLuxe.*\n', '', s)
s = re.sub(r'(?m)^\s*import\s+.*NavBar.*\n', '', s)

# Remove JSX tags that mount any NavBar*
s = re.sub(r'(?is)\n?\s*<NavBarLuxe\b[^>]*/>\s*', '\n', s)
s = re.sub(r'(?is)\n?\s*<NavBar\b[^>]*/>\s*', '\n', s)

p.write_text(s, encoding="utf-8")
print("OK: App.jsx patched (navbar duplicates removed if present)")
PY

echo "🔎 Sanity checks"
echo " - index.html SW references (should be empty):"
grep -n "serviceWorker" index.html || true
grep -n "registernavigator" index.html || true

echo "✅ Done. Next: purge navigateur (SW/cache) then pnpm dev."
