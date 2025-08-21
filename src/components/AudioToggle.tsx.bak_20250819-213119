'use client';
import { useEffect, useState } from "react";

export default function AudioToggle() {
  const [audio] = useState<HTMLAudioElement | null>(() => {
    if (typeof Audio === "undefined") return null;
    const a = new Audio("/audio/ambiance-luxe.mp3");
    a.muted = true;
    return a;
  });

  const [playing, setPlaying] = useState(false);

  useEffect(() => {
    if (!audio) return;
    audio.loop = true;
    return () => audio.pause();
  }, [audio]);

  const toggle = () => {
    if (!audio) return;
    audio.muted = false;
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
