'use client';

import { useEffect, useRef, useState } from 'react';

export default function AudioAmbient() {
  const audioRef = useRef(null);
  const [isMuted, setIsMuted] = useState(true);

  useEffect(() => {
    const alreadyPlayed = sessionStorage.getItem('audioPlayed');
    if (!alreadyPlayed) {
      const onUserInteraction = () => {
        if (audioRef.current) {
          audioRef.current.play().catch(() => {});
          audioRef.current.muted = false;
          setIsMuted(false);
          sessionStorage.setItem('audioPlayed', 'true');
        }
        window.removeEventListener('click', onUserInteraction);
      };

      window.addEventListener('click', onUserInteraction);
    }
  }, []);

  const toggleMute = () => {
    if (audioRef.current) {
      audioRef.current.muted = !isMuted;
      setIsMuted(!isMuted);
    }
  };

  return (
    <div className="fixed bottom-4 right-4 z-50 flex items-center gap-2">
      <audio
        ref={audioRef}
        src="/audio/ambiance-luxe-fixed.mp3"
        loop
        muted
        preload="auto"
      />
      <button
        onClick={toggleMute}
        aria-label={isMuted ? 'Activer le son' : 'Couper le son'}
        className={`relative p-2 rounded-full bg-black/60 hover:bg-black/80 transition border border-gold text-gold ${
          !isMuted ? 'animate-halo' : ''
        }`}
      >
        {isMuted ? '🔇' : '🔊'}
        {!isMuted && (
          <span className="absolute inset-0 rounded-full border border-gold/40 animate-ping" />
        )}
      </button>
    </div>
  );
}
