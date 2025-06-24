import React from 'react';

export default function Home() {
  return (
    <main className="font-sans mx-auto p-4 max-w-4xl">
      {/* Hero */}
      <section className="relative h-96 mb-12">
        <img src="/assets/hero-bg.jpg" alt="Événement Luxeevents" className="w-full h-full object-cover filter brightness-75"/>
        <div className="absolute inset-0 flex flex-col justify-center items-center text-center text-white px-4">
          <h1 className="text-4xl md:text-6xl font-extrabold mb-4">Luxe &amp; Élégance sur-Mesure</h1>
          <p className="text-lg md:text-2xl mb-6 max-w-2xl">
            Chez Luxeevents, chaque instant devient une expérience inoubliable.
          </p>
          <a href="/contact" className="px-8 py-3 bg-purple-700 hover:bg-purple-800 rounded-full font-semibold transition">
            Demander un devis
          </a>
        </div>
      </section>

      {/* Confiance */}
      <section className="mb-12">
        <h2 className="text-2xl font-bold text-purple-800 mb-4">Ils nous font confiance</h2>
        <blockquote className="italic text-gray-700 border-l-4 border-purple-600 pl-4">
          “Luxeevents a sublimé notre mariage comme un conte de fées moderne !”<br/>
          <strong>– Julie & Marc</strong>
        </blockquote>
      </section>

      {/* Services */}
      <section className="grid grid-cols-1 md:grid-cols-2 gap-8">
        {[
          { icon: '🎉', title: 'Organisation complète', desc: 'De la conception à la réalisation, on gère tout.' },
          { icon: '🤝', title: 'Coordination Jour J', desc: 'Profitez, on s’occupe du reste.' },
          { icon: '✨', title: 'Détails personnalisés', desc: 'Chaque événement est unique comme vous.' },
          { icon: '💎', title: 'Luxe accessible', desc: 'Raffinement à prix juste.' }
        ].map((s,i) => (
          <div key={i} className="bg-white p-6 rounded-lg shadow">
            <div className="text-4xl mb-4">{s.icon}</div>
            <h3 className="text-xl font-semibold text-purple-700 mb-2">{s.title}</h3>
            <p className="text-gray-600">{s.desc}</p>
          </div>
        ))}
      </section>
    </main>
  );
}
