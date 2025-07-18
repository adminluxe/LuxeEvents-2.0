import React from "react";

const testimonials = [
  {
    quote: "Une expérience exceptionnelle. L’équipe a sublimé notre mariage au-delà de nos attentes.",
    name: "Sophie & Julien"
  },
  {
    quote: "Professionnalisme, créativité, écoute. LuxeEvents a transformé notre événement corporate en chef-d’œuvre.",
    name: "Émilie R."
  },
  {
    quote: "Merci pour cette organisation parfaite. Tout était fluide, beau et élégant.",
    name: "Karim B."
  }
];

export default function Testimonials() {
  return (
    <section id="testimonials" className="py-20 text-center text-white px-6">
      <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] mb-8">Témoignages</h2>
      <div className="grid sm:grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
        {testimonials.map((t, i) => (
          <div key={i} className="bg-white/10 backdrop-blur-sm p-6 rounded-xl shadow-lg border border-[#d4af37]">
            <p className="italic text-white/80 mb-4">“{t.quote}”</p>
            <p className="font-semibold text-[#d4af37]">{t.name}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
