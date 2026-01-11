import React from "react";
import { Link } from "react-router-dom";

export const DEVIS_ROUTE = "/devis";
export const DEVIS_LABEL = "Demander un devis";

export default function PrimaryCTA({
  to = DEVIS_ROUTE,
  label = DEVIS_LABEL,
  variant = "default",
  className = "",
  children,
  title,
  ariaLabel,
  onClick,
}) {
  const base =
    "inline-flex items-center justify-center gap-2 select-none " +
    "transition-transform duration-200 active:scale-[0.99] focus:outline-none " +
    "focus-visible:ring-2 focus-visible:ring-yellow-400/60";

  const variants = {
    default:
      "px-5 py-3 rounded-full font-semibold text-black bg-gradient-to-r " +
      "from-yellow-300 via-yellow-400 to-yellow-300 shadow-lg shadow-yellow-400/20 " +
      "hover:shadow-yellow-400/30 hover:-translate-y-[1px]",
    hero:
      "px-7 py-4 rounded-full font-semibold text-black bg-gradient-to-r " +
      "from-yellow-300 via-yellow-400 to-yellow-300 shadow-xl shadow-yellow-400/25 " +
      "hover:shadow-yellow-400/35 hover:-translate-y-[1px]",
    mobile:
      "w-full px-6 py-4 rounded-full font-semibold text-black bg-gradient-to-r " +
      "from-yellow-300 via-yellow-400 to-yellow-300 shadow-xl shadow-yellow-400/25 " +
      "hover:shadow-yellow-400/35",
    nav:
      "px-4 py-2 rounded-full font-semibold text-black bg-yellow-400/90 " +
      "hover:bg-yellow-300 shadow-md shadow-yellow-400/20",
    inline:
      "px-0 py-0 rounded-none font-semibold text-yellow-300 hover:text-yellow-200 " +
      "underline underline-offset-4 decoration-yellow-400/60 hover:decoration-yellow-300/80",
    footerLink:
      "px-0 py-0 rounded-none font-medium text-white/80 hover:text-yellow-300 " +
      "transition-colors",
    icon:
      "w-10 h-10 rounded-full bg-black/60 text-white border border-white/10 " +
      "hover:border-yellow-400/40 hover:text-yellow-200 hover:bg-black/70",
  };

  const cls = [base, variants[variant] || variants.default, className]
    .filter(Boolean)
    .join(" ");

  const content = children ?? <span>{label}</span>;
  const t = title || label;
  const a = ariaLabel || label;

  return (
    <Link to={to} onClick={onClick} className={cls} title={t} aria-label={a}>
      {content}
    </Link>
  );
}
