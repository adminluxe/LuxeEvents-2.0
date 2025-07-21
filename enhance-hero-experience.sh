#!/bin/bash
echo "✨ Installation des effets immersifs (son, parallax, scroll-snap)..."

# 1. Hook useIntroSound.js
cat > src/hooks/useIntroSound.js << 'EOF'
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
EOF

# 2. Composant MuteToggle.jsx
cat > src/components/MuteToggle.jsx << 'EOF'
import { Volume2, VolumeX } from "lucide-react";

export default function MuteToggle({ muted, toggle }) {
  return (
    <button
      onClick={toggle}
      className="fixed top-4 right-4 z-50 p-2 bg-white/80 dark:bg-zinc-800/80 backdrop-blur rounded-full shadow-md"
    >
      {muted ? <VolumeX size={20} /> : <Volume2 size={20} />}
    </button>
  );
}
EOF

# 3. Mise à jour de HeroSection.jsx
sed -i '/import .*HeroSection/i import useIntroSound from "@/hooks/useIntroSound";import MuteToggle from "@/components/MuteToggle";' src/pages/HomePage.jsx

# Ajout dans HeroSection
cat > src/components/HeroSection.jsx << 'EOF'
import { motion } from "framer-motion";
import useIntroSound from "@/hooks/useIntroSound";
import MuteToggle from "@/components/MuteToggle";

export default function HeroSection() {
  const { audioRef, muted, toggleMute } = useIntroSound();

  return (
    <section
      className="h-screen w-full bg-cover bg-center scroll-snap-start relative"
      style={{ backgroundImage: "url('/images/hero.jpg')" }}
    >
      <audio ref={audioRef} src="/sounds/luxeevents-intro-sound.mp3" preload="auto" />
      <MuteToggle muted={muted} toggle={toggleMute} />
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1 }}
        className="flex flex-col items-center justify-center h-full text-white text-center backdrop-blur-sm bg-black/40"
      >
        <h1 className="text-4xl md:text-6xl font-bold mb-4 drop-shadow-lg">LuxeEvents</h1>
        <p className="text-lg md:text-xl max-w-xl">Le luxe, à la portée de tous.</p>
      </motion.div>
    </section>
  );
}
EOF

# 4. Activation scroll-snap via tailwind config (si pas déjà fait)
grep -q "scroll-snap" tailwind.config.js || echo '  plugins: [require("@tailwindcss/scroll-snap")],' >> tailwind.config.js

# 5. Ajout d'une classe CSS globale dans index.css
grep -q "scroll-snap-y" src/index.css || cat >> src/index.css << CSS

html {
  scroll-behavior: smooth;
}

body {
  scroll-snap-type: y mandatory;
}

section {
  scroll-snap-align: start;
}
CSS

# 6. Commit auto
git add src/hooks/useIntroSound.js src/components/MuteToggle.jsx src/components/HeroSection.jsx src/index.css tailwind.config.js
git commit -m "🎧 Son spatial + scroll-snap + Hero immersif avec mute toggle"

echo "✅ HeroSection enrichie avec son, scroll-snap, parallax et toggle mute."
