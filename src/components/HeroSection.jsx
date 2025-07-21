import { useState } from "react";
import ambiance from "../assets/audio/ambiance-luxe.mp3";

const HeroSection = () => {
  const [muted, setMuted] = useState(false);

  return (
    <section className="min-h-screen bg-black text-white flex flex-col justify-center items-center text-center px-4">
      <h1 className="text-4xl md:text-6xl font-bold mb-6 text-gold">
        Sublimez votre événement
      </h1>
      <p className="text-lg mb-10 text-gray-300">
        Le luxe à la portée de tous – Une expérience web inoubliable.
      </p>
      <button
        onClick={() => setMuted(!muted)}
        className="relative overflow-hidden rounded-full px-6 py-3 border border-gold hover:scale-105 transition-all duration-300"
      >
        {muted ? "Activer le son" : "Désactiver le son"}
      </button>
      <audio src={ambiance} autoPlay loop muted={muted} />
    </section>
  );
};

export default HeroSection;
