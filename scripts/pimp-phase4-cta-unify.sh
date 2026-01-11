#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

TS="$(date +%Y%m%d-%H%M%S)"
BK="_backup_cta_unify_${TS}"
mkdir -p "$BK"

echo "📦 Backup -> $BK"
cp -v src/components/NavBarLuxe.jsx "$BK/NavBarLuxe.jsx.bak" 2>/dev/null || true
cp -v src/components/HeroSection.jsx "$BK/HeroSection.jsx.bak" 2>/dev/null || true
cp -v src/components/ServicesSection.jsx "$BK/ServicesSection.jsx.bak" 2>/dev/null || true
cp -v src/components/PrimaryCTA.jsx "$BK/PrimaryCTA.jsx.bak" 2>/dev/null || true

echo "🧱 Write: src/components/PrimaryCTA.jsx"
cat > src/components/PrimaryCTA.jsx <<'JSX'
import React from "react";
import { Link } from "react-router-dom";

/**
 * PrimaryCTA — Single source of truth
 *
 * Variants:
 * - hero   : gros CTA (Hero)
 * - nav    : CTA compact (Navbar)
 * - mobile : CTA pleine largeur (sections mobile)
 */
const VARIANTS = {
  hero: "group relative inline-flex items-center justify-center rounded-full px-6 py-3 text-sm sm:text-base font-medium text-black bg-[#D4AF37] shadow-[0_18px_60px_rgba(212,175,55,0.25)] hover:shadow-[0_22px_80px_rgba(212,175,55,0.35)] transition",
  nav: "inline-flex items-center justify-center rounded-full px-4 sm:px-5 py-2.5 text-sm font-medium text-black bg-[#D4AF37] shadow-[0_18px_60px_rgba(212,175,55,0.22)] hover:shadow-[0_22px_80px_rgba(212,175,55,0.32)] transition",
  mobile: "inline-flex w-full items-center justify-center rounded-full px-6 py-3 text-sm font-medium text-black bg-[#D4AF37] shadow-[0_14px_40px_rgba(212,175,55,0.18)] hover:shadow-[0_18px_60px_rgba(212,175,55,0.28)] transition",
};

export default function PrimaryCTA({
  to = "/devis",
  label = "Demander un devis",
  variant = "hero",
  showArrow = true,
  className = "",
  ariaLabel,
  onClick,
}) {
  const base = VARIANTS[variant] || VARIANTS.hero;
  const a11y = ariaLabel || label;

  return (
    <Link
      to={to}
      onClick={onClick}
      aria-label={a11y}
      className={[base, className].join(" ").trim()}
    >
      {label}
      {showArrow ? (
        <span className="ml-2 opacity-80 group-hover:opacity-100 transition">→</span>
      ) : null}
      {/* micro ring luxe */}
      <span className="pointer-events-none absolute inset-0 rounded-full ring-1 ring-black/10" />
    </Link>
  );
}
JSX

echo "🧠 Rewrite: src/components/NavBarLuxe.jsx"
cat > src/components/NavBarLuxe.jsx <<'JSX'
import React, { useMemo } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import PrimaryCTA from "./PrimaryCTA.jsx";

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
            to="/devis"
            label="Devis"
            variant="nav"
            ariaLabel="Aller à la page devis"
          />
        </div>
      </div>
    </header>
  );
}
JSX

echo "✨ Rewrite: src/components/HeroSection.jsx"
cat > src/components/HeroSection.jsx <<'JSX'
import React from "react";
import PrimaryCTA from "./PrimaryCTA.jsx";

export default function HeroSection() {
  return (
    <section
      id="top"
      className="relative isolate overflow-hidden min-h-[92vh] flex items-center"
    >
      {/* Background image */}
      <div
        className="absolute inset-0 -z-20 bg-center bg-cover"
        style={{ backgroundImage: "url(/luxeevents-bg-hero.webp)" }}
        aria-hidden="true"
      />

      {/* Dark + luxe gradient overlay */}
      <div
        className="absolute inset-0 -z-10 bg-gradient-to-b from-black/70 via-black/55 to-black/85"
        aria-hidden="true"
      />

      {/* Soft gold glow */}
      <div className="absolute -z-10 inset-0 opacity-70" aria-hidden="true">
        <div className="absolute -top-32 left-1/2 -translate-x-1/2 w-[900px] h-[900px] rounded-full blur-3xl bg-[radial-gradient(circle_at_center,rgba(212,175,55,0.28),transparent_60%)]" />
        <div className="absolute bottom-[-420px] right-[-220px] w-[900px] h-[900px] rounded-full blur-3xl bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.08),transparent_60%)]" />
      </div>

      <div className="w-full px-5 sm:px-8">
        <div className="mx-auto max-w-6xl">
          <div className="max-w-3xl">
            {/* Kicker */}
            <div className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/5 px-4 py-2 text-[12px] sm:text-[13px] tracking-wide text-white/85 backdrop-blur">
              <span className="inline-block h-1.5 w-1.5 rounded-full bg-[#D4AF37]" />
              Événements haut de gamme • Belgique & Europe
            </div>

            {/* Headline */}
            <h1 className="mt-6 font-[500] leading-[1.05] text-white drop-shadow-[0_6px_22px_rgba(0,0,0,0.65)] text-4xl sm:text-5xl md:text-6xl">
              Le luxe à la portée de tous
              <span className="block mt-3 text-white/90 text-2xl sm:text-3xl md:text-4xl">
                Une expérience inoubliable.
              </span>
            </h1>

            <p className="mt-5 text-white/80 text-base sm:text-lg leading-relaxed max-w-2xl">
              Scénographie, coordination, prestataires premium, ambiance & détails
              millimétrés — on transforme ton événement en moment signature.
            </p>

            {/* CTAs */}
            <div className="mt-8 flex flex-col sm:flex-row items-stretch sm:items-center gap-3">
              <PrimaryCTA to="/devis" label="Demander un devis" variant="hero" />

              <a
                href="#services"
                className="inline-flex items-center justify-center rounded-full px-6 py-3 text-sm sm:text-base font-medium text-white border border-white/18 bg-white/5 hover:bg-white/10 backdrop-blur transition"
              >
                Découvrir nos services
              </a>
            </div>

            {/* Proof chips */}
            <div className="mt-10 flex flex-wrap gap-2">
              {[
                "Coordination Jour J",
                "Scénographie & design",
                "DJ / Live / Photo / Traiteur",
                "Expérience fluide & premium",
              ].map((t) => (
                <span
                  key={t}
                  className="rounded-full border border-white/12 bg-black/20 px-3 py-1.5 text-[12px] text-white/75 backdrop-blur"
                >
                  ✦ {t}
                </span>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Bottom fade */}
      <div className="absolute bottom-0 left-0 right-0 h-28 bg-gradient-to-t from-black/90 to-transparent -z-10" />
    </section>
  );
}
JSX

echo "🧩 Rewrite: src/components/ServicesSection.jsx (mobile CTA -> PrimaryCTA)"
cat > src/components/ServicesSection.jsx <<'JSX'
import React from "react";
import servicesDefault, { services as servicesNamed } from "../data/services.luxe.js";
import PrimaryCTA from "./PrimaryCTA.jsx";

export default function ServicesSection() {
  const services = (servicesNamed && servicesNamed.length ? servicesNamed : servicesDefault) || [];

  return (
    <section id="services" className="relative py-20 sm:py-24">
      {/* Section backdrop */}
      <div
        className="absolute inset-0 -z-10 bg-gradient-to-b from-black/0 via-black/10 to-black/0"
        aria-hidden="true"
      />

      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <div className="flex items-end justify-between gap-6">
          <div>
            <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[12px] tracking-wide text-white/80 backdrop-blur">
              <span className="text-[#D4AF37]">✦</span> Nos Services
            </div>
            <h2 className="mt-5 text-3xl sm:text-4xl font-[500] text-white">
              Une exécution premium, une signature LuxeEvents.
            </h2>
            <p className="mt-3 text-white/70 max-w-2xl">
              De la conception à la coordination, chaque détail est pensé pour un rendu
              élégant, fluide et mémorable.
            </p>
          </div>
        </div>

        {/* Grid */}
        <div className="mt-10 grid gap-4 sm:gap-5 md:grid-cols-2 lg:grid-cols-3">
          {services.map((s) => (
            <article
              key={s.id || s.title}
              className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/[0.04] backdrop-blur-md p-6 hover:bg-white/[0.06] transition"
            >
              {/* top glow line */}
              <div
                className="absolute inset-x-0 top-0 h-[2px] opacity-70 group-hover:opacity-100 transition"
                style={{
                  background:
                    "linear-gradient(90deg, rgba(212,175,55,0.0), rgba(212,175,55,0.9), rgba(212,175,55,0.0))",
                }}
                aria-hidden="true"
              />

              {/* subtle corner glow */}
              <div
                className="pointer-events-none absolute -top-20 -right-20 h-56 w-56 rounded-full blur-3xl opacity-0 group-hover:opacity-70 transition"
                style={{
                  background:
                    "radial-gradient(circle at center, rgba(212,175,55,0.25), transparent 60%)",
                }}
                aria-hidden="true"
              />

              <div className="flex items-start justify-between gap-4">
                <h3 className="text-lg font-[500] text-white">
                  <span className="text-[#D4AF37] mr-1">✦</span>
                  {s.title}
                </h3>
                {s.badge ? (
                  <span className="shrink-0 rounded-full border border-white/10 bg-black/30 px-3 py-1 text-[11px] text-white/75">
                    {s.badge}
                  </span>
                ) : null}
              </div>

              <p className="mt-3 text-sm leading-relaxed text-white/70">
                {s.description}
              </p>

              <div className="mt-5 flex items-center justify-between text-xs text-white/45">
                <span className="opacity-70">Service premium</span>
                <span className="opacity-0 group-hover:opacity-100 transition">→</span>
              </div>
            </article>
          ))}
        </div>

        {/* Mobile CTA (single source of truth) */}
        <div className="mt-10 sm:hidden">
          <PrimaryCTA to="/devis" label="Demander un devis" variant="mobile" />
        </div>
      </div>
    </section>
  );
}
JSX

echo "✅ Done. PrimaryCTA created + wired in Nav/Hero/Services."
echo "➡️ Next: pnpm dev (puis check /, /devis, et mobile)."
