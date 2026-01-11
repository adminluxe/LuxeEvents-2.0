import { useRef } from "react";

export default function LuxuryCTA({ href="/devis", label="Demander un devis", className="" }) {
  const btnRef = useRef(null);
  return (
    <a
      href={href}
      ref={btnRef}
      className={`group relative inline-flex items-center justify-center px-6 py-3 rounded-full font-semibold
                  text-black bg-yellow-400 hover:bg-yellow-300 transition-colors
                  focus:outline-none focus-visible:ring-2 focus-visible:ring-yellow-300
                  overflow-hidden ${className}`}
      aria-label={label}
    >
      {/* halo animé */}
      <span className="absolute inset-0 rounded-full opacity-40 group-hover:opacity-60 transition-opacity">
        <span className="absolute inset-0 rounded-full animate-ping bg-yellow-300/40"></span>
      </span>
      {/* lueur douce */}
      <span className="absolute -inset-2 rounded-full blur-2xl bg-yellow-400/25 pointer-events-none"></span>
      <span className="relative tracking-wide">{label}</span>
    </a>
  );
}
