import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
gsap.registerPlugin(ScrollTrigger);
export default function ScrollReveal({ children, className='' }) {
  const ref = useRef();
  useEffect(() => {
    gsap.from(ref.current, {
      opacity: 0, y: 50, duration: 1,
      scrollTrigger: { trigger: ref.current, start: 'top 80%' }
    });
  }, []);
  return <div ref={ref} className={className}>{children}</div>;
}
