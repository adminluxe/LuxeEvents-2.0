import { useEffect, useRef } from "react";

export default function ParallaxBackdrop({ className = "", strength = 0.15 }) {
  const ref = useRef(null);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const mq = window.matchMedia("(prefers-reduced-motion: reduce)");
    if (mq.matches) return;
    let rAF = 0;
    const onScroll = () => {
      const y = window.scrollY || 0;
      const t = Math.max(-40, Math.min(40, y * strength));
      el.style.transform = `translate3d(0, ${t}px, 0)`;
    };
    const loop = () => { onScroll(); rAF = requestAnimationFrame(loop); };
    rAF = requestAnimationFrame(loop);
    return () => cancelAnimationFrame(rAF);
  }, [strength]);
  return <div ref={ref} className={className} aria-hidden="true" />;
}
