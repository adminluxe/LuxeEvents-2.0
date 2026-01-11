import React, { useMemo } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import PrimaryCTA from "./PrimaryCTA.jsx";
import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";


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

    // Si pas sur home: on navigue vers /#id
    if (location.pathname !== "/") {
      navigate(`/#${id}`);
      return;
    }

    const el = document.getElementById(id);
    if (!el) return;

    // Offset navbar (88px)
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
                  isActive ? "text-white" : "text-white/65 hover:text-white",
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

        {/* CTA (single source of truth) */}
        <div className="flex items-center gap-2">
          <PrimaryCTA
            to={DEVIS_ROUTE}
            label="Devis"
            variant="nav"
            ariaLabel="Aller à la page devis"
          />
        </div>
      </div>
    </header>
  );
}
