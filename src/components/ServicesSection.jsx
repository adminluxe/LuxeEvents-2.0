import React from 'react';

export default function ServicesSection() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: ServicesSection.jsx</div>
    <section id="services" className="py-20 text-white text-center px-6">
      <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] mb-8">Nos Services</h2>
      <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-8 max-w-6xl mx-auto">
        {services.map((s, i) => (
          <div key={i} className="bg-white/10 backdrop-blur-sm p-6 rounded-xl shadow-lg border border-[#d4af37]">
            <h3 className="text-xl font-semibold text-[#d4af37] mb-2">{s.title}</h3>
            <p className="text-white/80">{s.description}</p>
          </div>
    </>
  );
}
