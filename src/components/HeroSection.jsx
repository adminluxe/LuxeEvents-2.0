import React from 'react';

export default function HeroSection() {
  return (
    <section className="min-h-[80vh] flex flex-col justify-center items-center text-center bg-gradient-to-b from-white to-yellow-100 px-4">
      <h1 className="text-4xl sm:text-5xl font-black text-yellow-600 drop-shadow-sm">
        Le luxe, à la portée de tous.
      </h1>
      <p className="mt-4 max-w-xl text-gray-600">
        Vivez une expérience événementielle inoubliable, élégante, immersive et accessible.
      </p>
      <a href="/demande-de-devis" className="mt-6 inline-block bg-yellow-500 hover:bg-yellow-600 text-white font-semibold px-6 py-3 rounded shadow transition">
        Demander un devis
      </a>
    </section>
  );
}
