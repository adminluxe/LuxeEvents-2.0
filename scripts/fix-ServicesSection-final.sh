#!/bin/bash

FILE="src/components/ServicesSection.jsx"

echo "🧼 Réécriture propre du fichier $FILE"

cat << 'EOL' > "$FILE"
import React from 'react';

const services = [
  { title: "Organisation clé en main", description: "Nous prenons en charge chaque détail pour sublimer votre événement." },
  { title: "Décoration personnalisée", description: "Ambiance sur-mesure pour un rendu inoubliable." },
  { title: "Animation & spectacles", description: "Artistes, shows, DJ pour dynamiser votre soirée." },
];

export default function ServicesSection() {
  return (
    <>
      <section className="py-16 bg-black text-white">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-center">Nos services exclusifs</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {services.map((s, index) => (
              <div key={index} className="bg-white/10 backdrop-blur-md p-6 rounded-xl">
                <h3 className="text-xl font-semibold mb-2">{s.title}</h3>
                <p className="text-white/80">{s.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </>
  );
}
EOL

echo "✅ Fichier restauré et propre."

echo "🔁 Rebuild en cours..."
npm run build && vercel --prod --force
