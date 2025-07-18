import React from "react";

export default function QuoteForm() {
  return (
    <section id="quote" className="py-20 text-white px-6 text-center">
      <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] mb-8">Demander un devis</h2>
      <form className="max-w-2xl mx-auto grid gap-6 text-left">
        <input type="text" placeholder="Nom complet" className="bg-white/10 p-4 rounded-lg text-white placeholder-white/60" required />
        <input type="email" placeholder="Email" className="bg-white/10 p-4 rounded-lg text-white placeholder-white/60" required />
        <input type="text" placeholder="Type d'événement" className="bg-white/10 p-4 rounded-lg text-white placeholder-white/60" required />
        <textarea placeholder="Votre message" className="bg-white/10 p-4 rounded-lg text-white placeholder-white/60 h-32" required />
        <button type="submit" className="bg-[#d4af37] text-black px-6 py-3 rounded-lg hover:bg-yellow-500 transition">
          Envoyer
        </button>
      </form>
    </section>
  );
}
