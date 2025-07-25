import React from 'react';

export default function ContactSection() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: ContactSection.jsx</div>
    <section className="min-h-screen py-20 px-4 bg-zinc-100 dark:bg-zinc-950 scroll-snap-start">
      <div className="max-w-4xl mx-auto text-center">
        <motion.h2
          initial={{ opacity: 0, x: -30 }}
          whileInView={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.6 }}
          className="text-3xl font-bold text-zinc-900 dark:text-yellow-100 mb-4"
        >
          Contact
        </motion.h2>
        <p className="text-zinc-700 dark:text-zinc-300 text-lg">
          Une idée, un projet, une envie ? Parlons-en et créons ensemble l’événement parfait.
        </p>
      </div>
    </>
  );
}
