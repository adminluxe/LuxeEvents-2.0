import React, { useRef, useEffect } from "react";
export default function LuxeParallax({ strength = 0.15, className = "", children }) {
  const ref = useRef(null);
  useEffect(() => {
    const el = ref.current; if (!el) return;
    const onScroll = () => {
      const r = el.getBoundingClientRect();
      const vh = window.innerHeight || 800;
      const center = r.top + r.height / 2 - vh / 2;
      const t = Math.max(-1, Math.min(1, center / vh));
      el.style.transform = `translateY(${Math.round(t * strength * 100)}px)`;
    };
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, [strength]);
  return <div ref={ref} className={className}>{children}</div>;
}
