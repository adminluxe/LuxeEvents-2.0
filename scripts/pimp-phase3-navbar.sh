#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
BK="_backup_pimp_phase3_${TS}"

echo "📦 Backup -> ${BK}"
mkdir -p "${BK}"

# Helpers
backup_if_exists () {
  local f="$1"
  if [ -f "$f" ]; then
    mkdir -p "${BK}/$(dirname "$f")"
    cp -a "$f" "${BK}/$f"
    echo "  - backup $f"
  fi
}

# Backup targets
backup_if_exists "src/App.jsx"
backup_if_exists "src/main.jsx"
backup_if_exists "src/index.css"
backup_if_exists "src/main.css"
backup_if_exists "src/components/NavBarLuxe.jsx"
backup_if_exists "src/components/HashScroller.jsx"

mkdir -p src/components

echo "✨ Write: src/components/HashScroller.jsx"
cat > src/components/HashScroller.jsx <<'EOC'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/**
 * Scroll to #hash targets in SPA (React Router) with a fixed-header offset.
 * Put <HashScroller /> INSIDE the Router.
 */
export default function HashScroller({ offset = 88 }) {
  const { hash } = useLocation();

  useEffect(() => {
    if (!hash) return;

    const id = hash.replace("#", "");
    const el = document.getElementById(id);
    if (!el) return;

    // Wait 1 frame for layout
    requestAnimationFrame(() => {
      const top = el.getBoundingClientRect().top + window.scrollY - offset;
      window.scrollTo({ top, behavior: "smooth" });
    });
  }, [hash, offset]);

  return null;
}
EOC

echo "✨ Write: src/components/NavBarLuxe.jsx"
cat > src/components/NavBarLuxe.jsx <<'EOC'
import React, { useMemo } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";

const ITEMS = [
  { label: "Accueil", to: "/#top", id: "top" },
  { label: "Services", to: "/#services", id: "services" },
  { label: "Réalisations", to: "/#realisations", id: "realisations" },
  { label: "Témoignages", to: "/#temoignages", id: "temoignages" },
  { label: "FAQ", to: "/#faq", id: "faq" },
];

export default function NavBarLuxe() {
  const location = useLocation();
  const navigate = useNavigate();

  const activeId = useMemo(() => {
    const h = (location.hash || "").replace("#", "");
    return h || "top";
  }, [location.hash]);

  const goSection = (id) => (e) => {
    e.preventDefault();

    // If not on home, navigate home with hash
    if (location.pathname !== "/") {
      navigate(`/#${id}`);
      return;
    }

    const el = document.getElementById(id);
    if (!el) return;

    const y = el.getBoundingClientRect().top + window.scrollY - 88;
    window.scrollTo({ top: y, behavior: "smooth" });
    history.replaceState(null, "", `/#${id}`);
  };

  return (
    <header className="fixed top-0 left-0 right-0 z-[80]">
      {/* glass backdrop */}
      <div className="absolute inset-0 bg-black/55 backdrop-blur-xl border-b border-white/10" />

      <div className="relative mx-auto max-w-6xl px-4 sm:px-8 py-3 flex items-center justify-between gap-3">
        {/* Brand */}
        <Link
          to="/"
          className="group inline-flex items-center gap-2 text-white/90 hover:text-white transition"
          aria-label="LuxeEvents"
        >
          <span className="inline-flex h-8 w-8 items-center justify-center rounded-full border border-white/12 bg-white/5">
            <span className="text-[#D4AF37]">✦</span>
          </span>
          <span className="font-[600] tracking-wide">LuxeEvents</span>
        </Link>

        {/* Links */}
        <nav className="hidden md:flex items-center gap-1">
          {ITEMS.map((it) => {
            const isActive = activeId === it.id;
            return (
              <a
                key={it.id}
                href={it.to}
                onClick={goSection(it.id)}
                className={[
                  "relative rounded-full px-4 py-2 text-sm transition",
                  isActive
                    ? "text-white"
                    : "text-white/65 hover:text-white",
                ].join(" ")}
              >
                {isActive ? (
                  <span className="absolute inset-0 rounded-full bg-white/10 border border-white/10" />
                ) : null}
                <span className="relative">{it.label}</span>
              </a>
            );
          })}
        </nav>

        {/* CTA */}
        <div className="flex items-center gap-2">
          <Link
            to="/devis"
            className="inline-flex items-center justify-center rounded-full px-4 sm:px-5 py-2.5 text-sm font-medium text-black bg-[#D4AF37] shadow-[0_18px_60px_rgba(212,175,55,0.22)] hover:shadow-[0_22px_80px_rgba(212,175,55,0.32)] transition"
          >
            Devis
            <span className="ml-2 opacity-80">→</span>
          </Link>
        </div>
      </div>
    </header>
  );
}
EOC

# Ensure CSS: smooth + scroll margin for anchors
CSS_FILE=""
if [ -f "src/index.css" ]; then CSS_FILE="src/index.css"; fi
if [ -z "$CSS_FILE" ] && [ -f "src/main.css" ]; then CSS_FILE="src/main.css"; fi

if [ -n "$CSS_FILE" ]; then
  echo "🎨 Patch CSS: $CSS_FILE"
  if ! grep -q "LUXE_SCROLL_TWEAKS" "$CSS_FILE"; then
    cat >> "$CSS_FILE" <<'EOCSS'

/* LUXE_SCROLL_TWEAKS */
html { scroll-behavior: smooth; }
section[id] { scroll-margin-top: 96px; }
/* END LUXE_SCROLL_TWEAKS */
EOCSS
  else
    echo "  - CSS tweak already present"
  fi
else
  echo "⚠️  No src/index.css or src/main.css found; skipping CSS tweaks."
fi

# Patch App.jsx to mount NavBar + HashScroller (BrowserRouter heuristic)
APP="src/App.jsx"
if [ -f "$APP" ]; then
  echo "🧩 Patch: $APP"

  # Add imports if missing
  grep -q 'NavBarLuxe' "$APP" || sed -i '1s@^@import NavBarLuxe from "./components/NavBarLuxe";\n@' "$APP"
  grep -q 'HashScroller' "$APP" || sed -i '1s@^@import HashScroller from "./components/HashScroller";\n@' "$APP"

  # If BrowserRouter present, inject components right after it opens
  if grep -q "BrowserRouter" "$APP"; then
    # Insert <HashScroller .../> and <NavBarLuxe/> once
    if ! grep -q "<NavBarLuxe" "$APP"; then
      # add inside the BrowserRouter tree
      # after first occurrence of <BrowserRouter>
      perl -0777 -i -pe 's/<BrowserRouter(\s*[^>]*)>/\<BrowserRouter$1\>\n      \<HashScroller offset={88} \/\>\n      \<NavBarLuxe \/\>/s' "$APP"
    fi
  else
    echo "⚠️  BrowserRouter not detected in App.jsx. Ajoute manuellement NavBarLuxe + HashScroller dans le composant qui contient ton Router."
  fi

else
  echo "❌ src/App.jsx introuvable. Stop."
  exit 1
fi

echo "✅ Phase 3 injectée."
echo "➡️ Next: pnpm build && vercel --prod --force --yes"
