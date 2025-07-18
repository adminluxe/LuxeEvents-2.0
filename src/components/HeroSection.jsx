import { motion } from "framer-motion";
import useIntroSound from "@/hooks/useIntroSound";
import { useEffect } from "react";
import MuteToggle from "@/components/MuteToggle";

export default function HeroSection() {
  const { audioRef, muted, toggleMute } = useIntroSound();

  useEffect(() => {
    const played = sessionStorage.getItem("introPlayed");
    if (!played && audioRef.current) {
      audioRef.current.play().catch(() => {});
      sessionStorage.setItem("introPlayed", "true");
    }
  }, []);

  return (
    <section
      className="h-screen w-full bg-cover bg-center scroll-snap-start relative"
      style={{ backgroundImage: "url('/media/images/photo-016.webp')" }}
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
