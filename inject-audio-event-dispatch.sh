#!/bin/bash
echo "🎧 Injection de l'auto-dispatch 'audio-ready' dans AudioAmbient.jsx..."

cat << 'JSX' > src/components/AudioAmbient.jsx
import React, { useEffect, useRef, useState } from "react";

function AudioAmbient() {
  const audioRef = useRef(null);
  const [isMuted, setIsMuted] = useState(false);

  useEffect(() => {
    const audio = audioRef.current;
    if (audio) {
      audio.volume = 0.4;
      audio.play().catch(() => {});
      audio.muted = false;
    }

    const timer = setTimeout(() => {
      console.log("🔔 Dispatch 'audio-ready'");
      window.dispatchEvent(new Event("audio-ready"));
    }, 5000); // max 5s fallback

    return () => clearTimeout(timer);
  }, []);

  const toggleMute = () => {
    const audio = audioRef.current;
    if (audio) {
      audio.muted = !isMuted;
      setIsMuted(audio.muted);
    }
  };

  return (
    <audio
      ref={audioRef}
      src="/audio/ambiance-luxe.mp3"
      autoPlay
      loop
      hidden
    />
  );
}

export default AudioAmbient;
JSX

echo "✅ AudioAmbient.jsx mis à jour avec fallback event"
