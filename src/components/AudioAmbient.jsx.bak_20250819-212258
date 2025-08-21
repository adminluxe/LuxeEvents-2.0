import { useEffect, useRef, useState } from "react";

/**
 * AudioAmbient — bouton (🔇 / 🔊) qui démarre/arrête l'ambiance au clic.
 * - Pas d'autoplay (évite les blocages)
 * - Formats conseillés : MP3 + OPUS dans /public/audio/
 */
export default function AudioAmbient({
  src = "/audio/ambiance-luxe.mp3",
  srcOpus = "/audio/ambiance-luxe.opus",
  className = ""
}) {
  const audioRef = useRef(null);
  const [on, setOn] = useState(false);

  useEffect(() => {
    const a = audioRef.current;
    if (!a) return;
    if (on) {
      // On tente de jouer (certains navigateurs protègent encore)
      a.play().catch(() => {});
    } else {
      a.pause();
      a.currentTime = 0;
    }
  }, [on]);

  return (
    <div className={`fixed bottom-6 right-6 z-50 ${className}`}>
      <button
        onClick={() => setOn((v) => !v)}
        className="rounded-full px-4 py-2 shadow-lg bg-yellow-400 text-black font-medium hover:brightness-105 transition"
        aria-pressed={on}
        aria-label={on ? "Couper l'ambiance" : "Activer l'ambiance"}
      >
        {on ? "🔊 Ambiance" : "🔇 Muet"}
      </button>

      <audio ref={audioRef} loop preload="auto">
        <source src={srcOpus} type="audio/ogg; codecs=opus" />
        <source src={src} type="audio/mpeg" />
      </audio>
    </div>
  );
}
