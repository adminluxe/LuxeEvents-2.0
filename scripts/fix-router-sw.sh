#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TS="$(date +%Y%m%d-%H%M%S)"
BK="_backup_fix_router_sw_${TS}"
mkdir -p "$BK"

echo "📦 Backup -> $BK"
cp -v index.html "$BK/index.html.bak" || true
cp -v src/main.jsx "$BK/main.jsx.bak" || true

# -------------------------
# 1) Rewrite src/main.jsx
# -------------------------
echo "🧠 Rewrite: src/main.jsx"

cat > src/main.jsx <<'MAIN'
import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";

import "./index.css";

import App from "./App.jsx";
import NavBarLuxe from "./components/NavBarLuxe.jsx";
import HashScroller from "./components/HashScroller.jsx";

// (Optionnel) SW géré dans le code (PAS dans index.html)
import { registerSW } from "./registerSW.js";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <BrowserRouter>
      <HashScroller offset={96} />
      <NavBarLuxe />
      <App />
    </BrowserRouter>
  </React.StrictMode>
);

// En dev: no-op (registerSW check import.meta.env.PROD)
// En prod: register SW si dispo
registerSW();
MAIN

# -------------------------------------------
# 2) Remove all inline SW scripts from index.html
# -------------------------------------------
echo "🧹 Clean: index.html (remove inline serviceWorker blocks)"

python3 - <<'PY'
import re, pathlib

p = pathlib.Path("index.html")
s = p.read_text(encoding="utf-8")

# Supprime tout <script>...</script> contenant "serviceWorker" ou "SW guard"
pattern = re.compile(r"<script\b[^>]*>.*?</script>\s*", re.IGNORECASE | re.DOTALL)

def keep(block: str) -> bool:
    b = block.lower()
    if "serviceworker" in b:  # couvre serviceWorker / navigator.serviceWorker / sw.js etc.
        return False
    if "sw guard" in b:
        return False
    return True

blocks = pattern.findall(s)
for blk in blocks:
    if not keep(blk):
        s = s.replace(blk, "")

# Nettoyage léger des espaces (optionnel)
s = re.sub(r"\n{3,}", "\n\n", s)

p.write_text(s, encoding="utf-8")
print("OK: index.html cleaned (inline SW removed)")
PY

echo "✅ Done."
echo "➡️ Next:"
echo "   pnpm dev"
echo "   (si prod) pnpm build && vercel --prod --force --yes"
