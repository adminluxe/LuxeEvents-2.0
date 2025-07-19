'use client';
import { useEffect, useState } from "react";

export default function AudioToggle() {
  const [audio] = useState<HTMLAudioElement | null>(
    typeof Audio !== "undefined" ? new Audio("/audio/ambiance-luxe.mp3") : null
  );
  const [playing, setPlaying] = useState(false);

  useEffect(() => {
    if (!audio) return;
    audio.loop = true;
    return () => {
      audio.pause();
    };
  }, [audio]);

  const toggle = () => {
    if (!audio) return;
    if (playing) {
      audio.pause();
    } else {
      audio.play();
    }
    setPlaying(!playing);
  };

  return (
    <button onClick={toggle} className="mt-4 text-sm text-white underline">
      {playing ? "🔇 Couper le son" : "🔊 Activer le son"}
    </button>
  );
}
