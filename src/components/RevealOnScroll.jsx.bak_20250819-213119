import React, { useEffect, useRef } from "react";
export default function RevealOnScroll({ as:Comp="div", className="", children, once=true, rootMargin="0px 0px -10% 0px" }) {
  const ref = useRef(null);
  useEffect(() => {
    const el = ref.current; if (!el) return;
    el.classList.add("reveal");
    const io = new IntersectionObserver(([entry]) => {
      if (entry.isIntersecting) {
        el.classList.add("is-visible");
        if (once) io.disconnect();
      } else if (!once) {
        el.classList.remove("is-visible");
      }
    }, { root: null, rootMargin, threshold: 0.1 });
    io.observe(el);
    return () => io.disconnect();
  }, [once, rootMargin]);
  return <Comp ref={ref} className={className}>{children}</Comp>;
}
