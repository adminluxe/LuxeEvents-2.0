import React from "react";
import FadeUpWrapper from "@/components/FadeUpWrapper";

const testimonials = [
  {
    name: "Sophie D.",
    feedback: "Un mariage magique, organisé de main de maître. LuxeEvents, c'est du haut niveau.",
    location: "Bruxelles",
  },
  {
    name: "Amine B.",
    feedback: "Anniversaire inoubliable. Équipe sérieuse, déco sublime. Merci !",
    location: "Etterbeek",
  },
  {
    name: "Léa M.",
    feedback: "Notre événement pro a bluffé tous les invités. Bravo pour l'élégance.",
    location: "Uccle",
  },
];

export default function Testimonials() {
  return (
    <section id="testimonials" className="py-16 bg-black/30 backdrop-blur-md text-white text-center">
      <FadeUpWrapper>
        <h2 className="text-4xl font-bold text-[#d4af37] mb-8">Témoignages</h2>
      </FadeUpWrapper>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-6xl mx-auto px-6">
        {testimonials.map((t, i) => (
          <FadeUpWrapper delay={i * 0.2} key={i}>
            <div className="p-6 bg-white/10 border border-[#d4af37] rounded-xl shadow-lg">
              <p className="italic mb-4">“{t.feedback}”</p>
              <p className="font-semibold">{t.name}</p>
              <p className="text-sm text-white/60">{t.location}</p>
            </div>
          </FadeUpWrapper>
        ))}
      </div>
    </section>
  );
}
