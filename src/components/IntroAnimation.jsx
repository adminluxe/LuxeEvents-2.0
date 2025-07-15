import React, { useEffect, useRef } from 'react';
import lottie from 'lottie-web';
import animationData from '../../public/assets/luxeevents-intro.json';

export default function IntroAnimation() {
  const container = useRef(null);

  useEffect(() => {
    const anim = lottie.loadAnimation({
      container: container.current,
      renderer: 'svg',
      loop: false,
      autoplay: true,
      animationData,
    });

    const timer = setTimeout(() => {
      container.current.style.display = 'none';
    }, 3000); // cache après 3 secondes

    return () => {
      anim.destroy();
      clearTimeout(timer);
    };
  }, []);

  return (
    <div ref={container} className="fixed inset-0 bg-white z-50 flex items-center justify-center" />
  );
}
