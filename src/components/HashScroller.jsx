import { useEffect } from "react";
import { useLocation } from "react-router-dom";

/**
 * HashScroller: scroll smooth vers #id avec offset (navbar).
 * Usage: <HashScroller offset={120} />
 */
export default function HashScroller({ offset = 120 }) {
  const { hash } = useLocation();

  useEffect(() => {
    if (!hash) return;

    const t = setTimeout(() => {
      const id = hash.replace("#", "");
      const el = document.getElementById(id);
      if (!el) return;

      // Si on a une navbar/header, on calcule un offset dynamique (plus fiable)
      const nav = document.querySelector("header, nav");
      const dyn = nav?.getBoundingClientRect?.().height ? (nav.getBoundingClientRect().height + 12) : offset;

      const y = el.getBoundingClientRect().top + window.scrollY - dyn;
      window.scrollTo({ top: Math.max(0, y), behavior: "smooth" });
    }, 50);

    return () => clearTimeout(t);
  }, [hash, offset]);

  return null;
}
