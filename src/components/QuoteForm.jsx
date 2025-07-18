import React from "react";
import FadeUpWrapper from "@/components/FadeUpWrapper";

export default function QuoteForm() {
  return (
    <section id="quote" className="py-16 bg-white text-black text-center">
      <FadeUpWrapper>
        <h2 className="text-4xl font-bold text-[#d4af37] mb-8">Demandez un devis</h2>
      </FadeUpWrapper>
      <form
        className="max-w-2xl mx-auto grid gap-4 text-left"
        onSubmit={(e) => {
          e.preventDefault();
          alert("Merci ! Nous vous recontactons sous 24h.");
        }}
      >
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Nom complet" required />
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Email" type="email" required />
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Téléphone" required />
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Type d'événement (ex : mariage)" />
        <textarea className="p-3 border border-gray-300 rounded-md" placeholder="Détails..." rows={4}></textarea>
        <button type="submit" className="bg-[#d4af37] text-white py-3 px-6 rounded-xl font-semibold hover:opacity-90">
          Envoyer ma demande
        </button>
      </form>
    </section>
  );
}
