import React from "react";

const services = [
  { title: "Mariages", description: "Des décors somptueux pour un jour inoubliable." },
  { title: "Événements d’entreprise", description: "Une organisation clé en main, élégante et professionnelle." },
  { title: "Anniversaires", description: "Des ambiances féériques, sur mesure." },
  { title: "Lancements de produit", description: "Faites rayonner votre marque avec un événement unique." },
];

export default function ServicesSection() {
  return (
    <section id="services" className="py-20 text-white text-center px-6">
      <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] mb-8">Nos Services</h2>
      <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-8 max-w-6xl mx-auto">
        {services.map((s, i) => (
          <div key={i} className="bg-white/10 backdrop-blur-sm p-6 rounded-xl shadow-lg border border-[#d4af37]">
            <h3 className="text-xl font-semibold text-[#d4af37] mb-2">{s.title}</h3>
            <p className="text-white/80">{s.description}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
