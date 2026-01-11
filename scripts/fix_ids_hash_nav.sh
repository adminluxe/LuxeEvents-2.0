#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

backup(){ [ -f "$1" ] && cp -a "$1" "$bdir/$(basename "$1").bak" || true; }

find_file() {
  # args: pattern1 pattern2 ...
  for p in "$@"; do
    f="$(grep -RIl --exclude='*.bak*' --exclude-dir='node_modules' --exclude-dir='_backups' "$p" src/components src/pages src/app 2>/dev/null | head -n 1 || true)"
    if [ -n "${f:-}" ]; then
      echo "$f"
      return 0
    fi
  done
  return 1
}

ensure_id_on_first_tag() {
  # args: file id
  local file="$1"
  local id="$2"

  [ -f "$file" ] || return 0

  # déjà OK ?
  if grep -Eq "<(section|div)[^>]*\bid=['\"]${id}['\"]" "$file"; then
    echo "✅ id=\"$id\" déjà présent -> $file"
    return 0
  fi

  backup "$file"

  if grep -q "<section" "$file"; then
    # ajoute id sur le 1er <section ...> si aucun id n’y figure
    if ! grep -Eq "<section[^>]*\bid=" "$file"; then
      sed -i '0,/<section/{s/<section/<section id="'"$id"'"/}' "$file"
      echo "✅ id=\"$id\" injecté sur <section> -> $file"
      return 0
    fi
  fi

  if grep -q "<div" "$file"; then
    if ! grep -Eq "<div[^>]*\bid=" "$file"; then
      sed -i '0,/<div/{s/<div/<div id="'"$id"'"/}' "$file"
      echo "✅ id=\"$id\" injecté sur <div> -> $file"
      return 0
    fi
  fi

  echo "⚠️ Impossible d’injecter proprement id=\"$id\" (tag non standard) -> $file"
}

# --- BACKUPS cibles ---
backup src/components/NavBarLuxe.jsx
backup src/components/HashScroller.jsx
backup src/main.jsx

# ---------------------------
# 1) HashScroller robuste
# ---------------------------
cat > src/components/HashScroller.jsx <<'EOF'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

function getEl(id) {
  try {
    return document.getElementById(decodeURIComponent(id));
  } catch {
    return document.getElementById(id);
  }
}

export default function HashScroller({ offset = 72, tries = 22, delay = 80 }) {
  const location = useLocation();

  useEffect(() => {
    const hash = window.location.hash || location.hash;
    if (!hash) return;

    const id = hash.replace(/^#/, "");
    if (!id) return;

    let cancelled = false;

    const attempt = (n) => {
      if (cancelled) return;
      const el = getEl(id);
      if (el) {
        el.scrollIntoView({ behavior: "smooth", block: "start" });
        setTimeout(() => window.scrollBy({ top: -offset, left: 0, behavior: "instant" }), 0);
        return;
      }
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
# 2) NavBarLuxe hash-proof (active suit hashchange)
# ---------------------------
cat > src/components/NavBarLuxe.jsx <<'EOF'
import React, { useEffect, useMemo, useState, useCallback } from "react";
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

  const go = useCallback(
    (id) => {
      // si pas sur home, on y va + hash
      if (location.pathname !== "/") {
        navigate({ pathname: "/", hash: "#" + id }, { replace: false });
        return;
      }

      // on pousse un vrai changement hash (déclenche hashchange + reflète url)
      if (window.location.hash !== "#" + id) {
        window.location.hash = id;
      } else {
        // même hash : on force scroll quand même
        const el = document.getElementById(id);
        if (el) {
          el.scrollIntoView({ behavior: "smooth", block: "start" });
          setTimeout(() => window.scrollBy({ top: -72, left: 0, behavior: "instant" }), 0);
        }
      }
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

# ---------------------------
# 3) Inject IDs dans les sections (auto-détection)
# ---------------------------
services_file="$(find_file 'Nos Services' 'Services premium' 'Nos services' || true)"
reals_file="$(find_file 'Réalisations' 'Nos Réalisations' 'realisations' 'Galerie' || true)"
temoi_file="$(find_file 'Témoignages' 'temoignages' 'Ils nous ont fait confiance' 'Avis' || true)"

echo
echo "🔎 Fichiers détectés:"
echo "  services:     ${services_file:-'(introuvable)'}"
echo "  realisations: ${reals_file:-'(introuvable)'}"
echo "  temoignages:  ${temoi_file:-'(introuvable)'}"
echo

[ -n "${services_file:-}" ] && ensure_id_on_first_tag "$services_file" "services" || true
[ -n "${reals_file:-}" ] && ensure_id_on_first_tag "$reals_file" "realisations" || true
[ -n "${temoi_file:-}" ] && ensure_id_on_first_tag "$temoi_file" "temoignages" || true

echo
echo "✅ Done. Backups: $bdir"
echo "➡️ Redémarre vite:"
echo "   ctrl+c ثم  pnpm -s run dev"
