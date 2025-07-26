import React from 'react';

export default function TestimonialsSection() {
  return (
    <section className="py-16 px-4 text-center bg-black text-white">
      <h2 className="text-2xl md:text-4xl font-bold mb-8">Ils nous ont fait confiance</h2>
      <div className="grid md:grid-cols-3 gap-6">
        <div className="bg-white/10 p-6 rounded-xl backdrop-blur">Un service incroyable, tout était parfait! ⭐⭐⭐⭐⭐</div>
        <div className="bg-white/10 p-6 rounded-xl backdrop-blur">Une organisation digne des plus grands. Merci! 🙏</div>
        <div className="bg-white/10 p-6 rounded-xl backdrop-blur">Une soirée magique, on recommande à 200%! ✨</div>
      </div>
    </section>
  );
}
