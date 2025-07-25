import React, { useState, useEffect } from 'react';
import { Player } from '@lottiefiles/react-lottie-player';
import animationData from '../assets/intro-luxe.json';

export default function IntroAnimationLottie({ onFinish }) {
  const [isVisible, setIsVisible] = useState(true);

  useEffect(() => {
    console.log('🟢 MONTÉ: IntroAnimationLottie');
    const timeout = setTimeout(() => {
      setIsVisible(false);
      onFinish?.();
    }, 6000);
    return () => clearTimeout(timeout);
  }, [onFinish]);

  if (!isVisible) return null;

  return (
    <>
      <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">
        ✅ VISIBLE: IntroAnimationLottie.jsx
      </div>
      <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
        <Player
          autoplay
          keepLastFrame
          src={animationData}
          style={{ height: '300px', width: '300px' }}
        />
      </div>
    </>
  );
}
