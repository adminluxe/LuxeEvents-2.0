import React from 'react';

export default function RevealSection() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: RevealSection.jsx</div>
    <section className="h-screen snap-start bg-white flex flex-col md:flex-row items-center justify-center p-8">
      {/* Image */}
      <motion.img
        src="/images/luxeevents-story.jpg"
        alt="LuxeEvents Reveal"
        initial={{ x: -100, opacity: 0 }}
        whileInView={{ x: 0, opacity: 1 }}
        transition={{ duration: 1 }}
        className="w-full md:w-1/2 rounded-2xl shadow-xl object-cover"
      />

      {/* Texte */}
      <motion.div style={{ opacity: 1 }}
        className="mt-8 md:mt-0 md:ml-12 max-w-xl text-center md:text-center"
        initial={{ x: 100, opacity: 0 }}
        whileInView={{ x: 0, opacity: 1 }}
        transition={{ duration: 1, delay: 0.3 }}
      >
        <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] drop-shadow-lg">Une révélation immersive</h2>
        <p className="text-lg text-gray-800">
          Découvrez la magie derrière chaque événement : élégance, lumière, émotion.
          LuxeEvents ne se contente pas d’organiser, il révèle une nouvelle expérience du luxe.
        </p>
      </motion.div>
    </section>
  );
}
    </>
  );
}
