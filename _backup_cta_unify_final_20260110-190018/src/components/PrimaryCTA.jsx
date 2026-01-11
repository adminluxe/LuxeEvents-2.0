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
