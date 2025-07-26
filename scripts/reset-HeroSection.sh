#!/bin/bash

FILE="src/components/HeroSection.jsx"

echo "🧼 Reset complet du composant HeroSection.jsx..."

cat << 'EOL' > "$FILE"
import React, { useState } from 'react';

export default function HeroSection() {
  const [muted, setMuted] = useState(true);

  return (
    <>
      <section className="min-h-screen flex flex-col justify-center items-center text-center px-4">
        <h1 className="text-3xl md:text-5xl font-bold text-gold mb-4">
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
    </>
  );
}
EOL

echo "✅ HeroSection réécrit avec succès."
echo "🚀 Rebuild propre + déploiement Vercel..."
npm run build && vercel --prod --force --yes
