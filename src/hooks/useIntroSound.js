import { useEffect, useRef, useState } from "react";

export default function useIntroSound() {
  const audioRef = useRef(null);
  const [muted, setMuted] = useState(false);

  useEffect(() => {
    const hasPlayed = sessionStorage.getItem("luxeevents-sound-played");
    if (!hasPlayed && audioRef.current) {
      audioRef.current.volume = 0.4;
      audioRef.current.play().catch(() => {});
      sessionStorage.setItem("luxeevents-sound-played", "true");
    }
  }, []);

  return {
    audioRef,
    muted,
    toggleMute: () => {
      if (audioRef.current) {
        audioRef.current.muted = !audioRef.current.muted;
        setMuted(audioRef.current.muted);
      }
    },
  };
}
