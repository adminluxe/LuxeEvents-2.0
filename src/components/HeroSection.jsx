import React, { useState } from 'react';
import './HeroSection.css';

export default function HeroSection() {
  const [muted, setMuted] = useState(true);

  return (
    <section className="min-h-screen flex flex-col justify-center items-center text-center px-4 bg-[url('/bg-luxeevents.png')] bg-cover bg-center">
      <div className="diamond-animation mb-4"></div>
      <h1 className="text-3xl md:text-5xl font-bold text-gold mb-4 animate-fadeInUp">
        Sublimez votre événement
      </h1>
      <p className="text-black/80 dark:text-white/80 mb-6">
        Le luxe à la portée de tous – Pour une expérience inoubliable.
      </p>
      <button
        className="bg-white dark:bg-black border border-gold text-gold px-4 py-2 rounded hover:bg-gold hover:text-white transition"
        onClick={() => setMuted(!muted)}
      >
        {muted ? 'Activer le son' : 'Désactiver le son'}
      </button>
      <audio
        src="/audio/ambiance-luxe.mp3"
        autoPlay
        loop
        muted={muted}
        className="hidden"
      />
    </section>
  );
}
