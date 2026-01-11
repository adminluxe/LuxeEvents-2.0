#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

backup(){ [ -f "$1" ] && cp -a "$1" "$bdir/$(echo "$1" | tr '/' '_').bak" || true; }

backup src/utils/scrollToId.js
backup src/components/HashScroller.jsx
backup src/components/NavBarLuxe.jsx

# ---------------------------
# scrollToId (container-aware + snap off)
# ---------------------------
cat > src/utils/scrollToId.js <<'EOF'
function isScrollable(el) {
  if (!el || el === document.body) return false;
  const st = window.getComputedStyle(el);
  const oy = st.overflowY;
  return (oy === "auto" || oy === "scroll") && el.scrollHeight > el.clientHeight + 2;
}

function findScrollParent(el) {
  let p = el?.parentElement || null;
  while (p) {
    if (isScrollable(p)) return p;
    p = p.parentElement;
  }
  return null;
}

function disableSnapTemporarily(container, ms = 450) {
  if (!container) return () => {};
  const st = window.getComputedStyle(container);
  const snap = st.scrollSnapType;
  if (!snap || snap === "none") return () => {};

  const prev = container.style.scrollSnapType;
  container.style.scrollSnapType = "none";

  const t = setTimeout(() => {
    container.style.scrollSnapType = prev || "";
  }, ms);

  return () => clearTimeout(t);
}

export function scrollToId(id, { offset = 72, behavior = "smooth" } = {}) {
  if (!id) return false;

  const safeId = (() => {
    try { return decodeURIComponent(id); } catch { return id; }
  })();

  const el = document.getElementById(safeId);
  if (!el) return false;

  const container = findScrollParent(el);

  // --- Case 1: container scrollable (common with snap layouts)
  if (container) {
    const cleanup = disableSnapTemporarily(container, 500);

    const cRect = container.getBoundingClientRect();
    const eRect = el.getBoundingClientRect();

    const currentTop = container.scrollTop;
    const targetTop = currentTop + (eRect.top - cRect.top) - offset;

    container.scrollTo({ top: targetTop, behavior });
    setTimeout(cleanup, 520);
    return true;
  }

  // --- Case 2: normal window scroll
  const cleanup = disableSnapTemporarily(document.documentElement, 500);

  el.scrollIntoView({ behavior, block: "start" });
  setTimeout(() => window.scrollBy({ top: -offset, left: 0, behavior: "instant" }), 0);
  setTimeout(cleanup, 520);
  return true;
}
EOF

# ---------------------------
# HashScroller robuste (utilise scrollToId)
# ---------------------------
cat > src/components/HashScroller.jsx <<'EOF'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";
import { scrollToId } from "../utils/scrollToId";

export default function HashScroller({ offset = 72, tries = 26, delay = 80 }) {
  const location = useLocation();

  useEffect(() => {
    const hash = window.location.hash || location.hash;
    if (!hash) return;

    const id = hash.replace(/^#/, "");
    if (!id) return;

    let cancelled = false;

    const attempt = (n) => {
      if (cancelled) return;
      const ok = scrollToId(id, { offset, behavior: "smooth" });
      if (ok) return;
      if (n <= 0) return;
      setTimeout(() => attempt(n - 1), delay);
    };

    requestAnimationFrame(() => attempt(tries));
    return () => { cancelled = true; };
  }, [location.pathname, location.hash, offset, tries, delay]);

  return null;
}
EOF

# ---------------------------
# NavBarLuxe (click = hash + scrollToId direct)
# ---------------------------
cat > src/components/NavBarLuxe.jsx <<'EOF'
import React, { useEffect, useMemo, useState, useCallback } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { scrollToId } from "../utils/scrollToId";

const ITEMS = [
  { id: "top", label: "Accueil" },
  { id: "services", label: "Services" },
  { id: "realisations", label: "Réalisations" },
  { id: "temoignages", label: "Témoignages" },
];

function cls(...a) { return a.filter(Boolean).join(" "); }

export default function NavBarLuxe() {
  const location = useLocation();
  const navigate = useNavigate();
  const [hash, setHash] = useState(() => window.location.hash || "#top");

  useEffect(() => {
    const onHash = () => setHash(window.location.hash || "#top");
    window.addEventListener("hashchange", onHash);
    return () => window.removeEventListener("hashchange", onHash);
  }, []);

  const activeId = useMemo(() => {
    if (location.pathname !== "/") return "";
    const h = (hash || "#top").replace(/^#/, "");
    return h || "top";
  }, [location.pathname, hash]);

  const go = useCallback((id) => {
    // si pas sur home, on y va avec hash (HashScroller fera le boulot)
    if (location.pathname !== "/") {
      navigate({ pathname: "/", hash: "#" + id }, { replace: false });
      return;
    }

    // pousse le hash (déclenche hashchange)
    if (window.location.hash !== "#" + id) {
      window.location.hash = id;
    }

    // scroll immédiat (radical)
    // même si HashScroller rate, celui-ci est container-aware + snap-off.
    requestAnimationFrame(() => {
      scrollToId(id, { offset: 72, behavior: "smooth" });
    });
  }, [location.pathname, navigate]);

  return (
    <div className="fixed top-4 left-1/2 -translate-x-1/2 z-[80] w-[min(980px,94vw)]">
      <div className="flex items-center justify-between gap-3 rounded-full border border-white/10 bg-black/45 backdrop-blur-xl px-4 py-2 shadow-[0_10px_35px_rgba(0,0,0,0.55)]">
        <div className="flex items-center gap-2">
          <span className="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white/5 border border-white/10">✦</span>
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
                  "rounded-full px-4 py-2 text-sm transition border border-transparent",
                  isActive ? "bg-white/10 text-white border-white/15" : "text-white/60 hover:text-white hover:bg-white/5"
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
echo "✅ Radical scroll fix injecté."
echo "📦 Backups: $bdir"
echo "➡️ Restart:"
echo "   ctrl+c"
echo "   pnpm -s run dev"
