import React from 'react';

export default function TimelineSection() {
  const steps = [
    "Premier contact et écoute",
    "Proposition sur mesure",
    "Validation et préparation",
    "Jour J en toute sérénité",
  ];

  return (
    <>
      <section className="py-16 bg-white dark:bg-black text-center">
        <h2 className="text-2xl md:text-4xl font-bold text-gold mb-8">
          Notre processus magique
        </h2>
        <div className="max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-4 gap-6">
          {steps.map((step, index) => (
            <div
              key={index}
              className="p-4 border border-gold rounded shadow hover:scale-105 transition"
            >
              <span className="text-gold md:text-2xl text-xl font-semibold">{index + 1}</span>
              <p className="text-black dark:text-white mt-2">{step}</p>
            </div>
          ))}
        </div>
      </section>
    </>
  );
}
