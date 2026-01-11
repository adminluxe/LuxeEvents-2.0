#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

cp -a src/components/HashScroller.jsx "$bdir/HashScroller.jsx.bak" 2>/dev/null || true
cp -a src/components/NavBarLuxe.jsx "$bdir/NavBarLuxe.jsx.bak" 2>/dev/null || true
cp -a src/main.jsx "$bdir/main.jsx.bak" 2>/dev/null || true

# ---------------------------
# 1) HashScroller robuste
# ---------------------------
cat > src/components/HashScroller.jsx <<'EOF'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

function getElFromHash(hash) {
  if (!hash || hash === "#") return null;
  const id = decodeURIComponent(hash.replace(/^#/, ""));
  return document.getElementById(id);
}

function smoothScrollToEl(el, offset = 72) {
  if (!el) return false;
  el.scrollIntoView({ behavior: "smooth", block: "start" });
  // petit offset pour navbar sticky (après un tick)
  setTimeout(() => {
    window.scrollBy({ top: -offset, left: 0, behavior: "instant" });
  }, 0);
  return true;
}

export default function HashScroller({ offset = 72, tries = 18, delay = 80 }) {
  const location = useLocation();

  useEffect(() => {
    const hash = location.hash;
    if (!hash) return;

    let cancelled = false;

    const attempt = (n) => {
      if (cancelled) return;
      const el = getElFromHash(hash);
      if (el) {
        smoothScrollToEl(el, offset);
        return;
      }
      if (n <= 0) return;
      setTimeout(() => attempt(n - 1), delay);
    };

    // Après paint + rendu sections
    requestAnimationFrame(() => attempt(tries));

    return () => {
      cancelled = true;
    };
  }, [location.pathname, location.hash, offset, tries, delay]);

  return null;
}
EOF

# ---------------------------
# 2) NavBarLuxe actif + scroll au click (fiable)
# ---------------------------
cat > src/components/NavBarLuxe.jsx <<'EOF'
import React, { useCallback, useMemo } from "react";
import { useLocation, useNavigate } from "react-router-dom";

const ITEMS = [
  { id: "top", label: "Accueil" },
  { id: "services", label: "Services" },
  { id: "realisations", label: "Réalisations" },
  { id: "temoignages", label: "Témoignages" },
];

function cls(...a) {
  return a.filter(Boolean).join(" ");
}

export default function NavBarLuxe() {
  const location = useLocation();
  const navigate = useNavigate();

  const activeId = useMemo(() => {
    if (location.pathname !== "/") return "";
    const h = (location.hash || "").replace(/^#/, "");
    return h || "top";
  }, [location.pathname, location.hash]);

  const go = useCallback(
    async (id) => {
      // Si on n'est pas sur la home, on y revient d'abord
      if (location.pathname !== "/") {
        navigate("/#" + id);
        return;
      }

      // on force hash (pour back/forward + URL)
      history.replaceState(null, "", "#" + id);

      const tryScroll = (n) => {
        const el = document.getElementById(id);
        if (el) {
          el.scrollIntoView({ behavior: "smooth", block: "start" });
          setTimeout(() => window.scrollBy({ top: -72, left: 0, behavior: "instant" }), 0);
          return;
        }
        if (n <= 0) return;
        setTimeout(() => tryScroll(n - 1), 80);
      };

      requestAnimationFrame(() => tryScroll(18));
    },
    [location.pathname, navigate]
  );

  return (
    <div className="fixed top-4 left-1/2 -translate-x-1/2 z-[80] w-[min(980px,94vw)]">
      <div className="flex items-center justify-between gap-3 rounded-full border border-white/10 bg-black/45 backdrop-blur-xl px-4 py-2 shadow-[0_10px_35px_rgba(0,0,0,0.55)]">
        <div className="flex items-center gap-2">
          <span className="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white/5 border border-white/10">
            ✦
          </span>
          <span className="text-sm font-semibold tracking-wide text-white/90">LuxeEvents</span>
        </div>

        <nav className="flex items-center gap-1">
          {ITEMS.map((it) => {
            const isActive = activeId === it.id;
            return (
              <button
                key={it.id}
                onClick={() => go(it.id)}
                className={cls(
                  "rounded-full px-4 py-2 text-sm transition",
                  "border border-transparent",
                  isActive
                    ? "bg-white/10 text-white border-white/15"
                    : "text-white/60 hover:text-white hover:bg-white/5"
                )}
                aria-current={isActive ? "page" : undefined}
              >
                {it.label}
              </button>
            );
          })}
        </nav>

        <button
          onClick={() => navigate("/devis")}
          className="rounded-full px-4 py-2 text-sm border border-[#d4af37]/25 bg-[#d4af37]/10 text-[#f5e7b7] hover:bg-[#d4af37]/15 transition"
        >
          Demander un devis
        </button>
      </div>
    </div>
  );
}
EOF

echo
echo "✅ Patch OK."
echo "📦 Backups dans: $bdir"
echo
echo "➡️ Redémarre le dev server:"
echo "   (1) ctrl+c"
echo "   (2) pnpm -s run dev"
