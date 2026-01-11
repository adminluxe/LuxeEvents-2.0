#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
mkdir -p scripts _backups src/components

die(){ echo "ERROR: $*" >&2; exit 1; }
ok(){ echo -e "\n✅ $*\n"; }
info(){ echo -e "\n🔎 $*\n"; }

[ -f src/main.jsx ] || die "src/main.jsx introuvable (tu n'es pas à la racine du repo ?)"

# --- Backup safe ---
cp -a src/main.jsx "_backups/main.jsx.${ts}.bak"
[ -f src/App.jsx ] && cp -a src/App.jsx "_backups/App.jsx.${ts}.bak" || true

# --- HashScroll component (BrowserRouter-safe) ---
cat > src/components/HashScroll.jsx <<'EOF'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

function scrollToHash(hash) {
  if (!hash || hash === "#") return false;
  const id = decodeURIComponent(hash.replace(/^#/, ""));
  const el = document.getElementById(id);
  if (!el) return false;
  el.scrollIntoView({ behavior: "smooth", block: "start" });
  return true;
}

export default function HashScroll({ offset = 0 }) {
  const location = useLocation();

  useEffect(() => {
    const hash = location.hash;
    if (!hash) return;

    let cancelled = false;

    const attempt = (tries) => {
      if (cancelled) return;

      const ok = scrollToHash(hash);
      if (ok) {
        if (offset) {
          // remonte un poil si tu as une navbar sticky
          window.scrollBy({ top: -offset, left: 0, behavior: "instant" });
        }
        return;
      }
      if (tries <= 0) return;
      setTimeout(() => attempt(tries - 1), 80);
    };

    // après paint + rendu sections
    requestAnimationFrame(() => attempt(15));

    return () => { cancelled = true; };
  }, [location.pathname, location.hash, offset]);

  return null;
}
EOF

# --- Choose target: prefer src/main.jsx if it contains BrowserRouter ---
TARGET=""
if grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' '<BrowserRouter' src/main.jsx >/dev/null 2>&1; then
  TARGET="src/main.jsx"
elif [ -f src/App.jsx ] && grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' '<BrowserRouter' src/App.jsx >/dev/null 2>&1; then
  TARGET="src/App.jsx"
else
  die "Aucun <BrowserRouter> trouvé dans src/main.jsx ou src/App.jsx (tu utilises peut-être RouterProvider ?)"
fi

info "Patch du bon fichier (hors .bak): ${TARGET}"

# --- Ensure import HashScroll ---
if ! grep -q 'HashScroll' "$TARGET"; then
  if grep -q 'react-router-dom' "$TARGET"; then
    # ajoute l'import juste après la ligne react-router-dom
    sed -i '0,/react-router-dom/s//&\nimport HashScroll from ".\/components\/HashScroll";/' "$TARGET"
  else
    # fallback: ajoute tout en haut
    sed -i '1s|^|import HashScroll from "./components/HashScroll";\n|' "$TARGET"
  fi
fi

# --- Inject <HashScroll /> right after <BrowserRouter> ---
if ! grep -q '<HashScroll' "$TARGET"; then
  sed -i '0,/<BrowserRouter[^>]*>/s//&\n      <HashScroll offset={8} \/>/' "$TARGET"
fi

# --- Quick sanity checks ---
info "Vérif HashScroll (doit apparaître UNIQUEMENT dans les fichiers réels, pas les .bak)"
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' 'HashScroll' src | sed -n '1,120p' || true

info "Vérif id=realisations"
grep -RIn --exclude='*.bak*' --exclude-dir='node_modules' 'id="realisations"' src/components src/pages src/app 2>/dev/null || true

ok "Patch terminé. Lance ton dev server et clique sur Réalisations."
echo "➡️  Commandes:"
echo "   pnpm -s run dev"
