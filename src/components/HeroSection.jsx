import React, { useState } from 'react';
import ambiance from '/audio/ambiance-luxe.mp3';

export default function HeroSection() {
  const [muted, setMuted] = useState(true);

  return (
    <>
      <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">
        ✅ VISIBLE: HeroSection.jsx
      </div>
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
    </>
  );
}
