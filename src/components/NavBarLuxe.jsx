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
