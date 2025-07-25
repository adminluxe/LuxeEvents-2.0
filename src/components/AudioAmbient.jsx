import React, { useEffect } from 'react';

export default function AudioAmbient() {
  useEffect(() => {
    console.log('🟢 MONTÉ: AudioAmbient');
  }, []);

  return (
    <>
      <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">
        ✅ VISIBLE: AudioAmbient.jsx
      </div>
      <audio
        autoPlay
        muted
        loop
        playsInline
        preload="auto"
        src="/audio/ambiance-luxe.mp3"
        id="bg-audio"
      />
    </>
  );
}
