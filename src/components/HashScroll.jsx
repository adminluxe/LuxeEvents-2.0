import { useEffect } from "react";
import { useLocation } from "react-router-dom";

function scrollToHash(hash) {
  if (!hash || hash === "#") return false;
  const id = decodeURIComponent(hash.replace(/^#/, ""));
  const el = document.getElementById(id);
  if (!el) return false;
  el.scrollIntoView({ behavior: "smooth", block: "start" });
  return true;
}

export default function HashScroller({ offset = 0 }) {
  const location = useLocation();

  useEffect(() => {
    const hash = location.hash;
    if (!hash) return;

    let cancelled = false;

    const attempt = (tries) => {
      if (cancelled) return;

      const ok = scrollToHash(hash);
      if (ok) {
        if (offset) {
          // remonte un poil si tu as une navbar sticky
          window.scrollBy({ top: -offset, left: 0, behavior: "instant" });
        }
        return;
      }
      if (tries <= 0) return;
      setTimeout(() => attempt(tries - 1), 80);
    };

    // après paint + rendu sections
    requestAnimationFrame(() => attempt(15));

    return () => { cancelled = true; };
  }, [location.pathname, location.hash, offset]);

  return null;
}
