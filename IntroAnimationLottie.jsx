import { useEffect } from 'react';
import '@lottiefiles/lottie-player';

export default function IntroAnimationLottie({ onFinish }) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onFinish();
    }, 3500); // duréee de l’animation
    return () => clearTimeout(timer);
  }, [onFinish]);

  return (
    <div className="fixed inset-0 z-50 bg-ivory flex items-center justify-center">
      <lottie-player
        src="/lottie/luxeevents.json"
        background="transparent"
        speed="1"
        autoplay
        style={{ width: '100%', maxWidth: '420px', height: 'auto' }}
      ></lottie-player>
    </div>
  );
}
