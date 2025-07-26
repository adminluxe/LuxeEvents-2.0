import React from 'react';

export default function ServicesSection() {
  const services = [
    { title: 'Mariages', description: 'Célébrez votre amour avec élégance.' },
    { title: 'Corporate', description: 'Des événements d’entreprise qui marquent.' },
    { title: 'Privé', description: 'Des souvenirs inoubliables sur mesure.' },
  ];

  return (
    <>
      <section className="py-16 text-center">
        <h2 className="text-2xl md:text-4xl font-semibold mb-6 text-gold">Nos Services</h2>
        <div className="grid md:grid-cols-3 gap-8 md:px-8 px-4">
          {services.map((s, index) => (
            <div key={index} className="bg-white/10 backdrop-blur p-6 rounded shadow">
              <h3 className="md:text-2xl text-xl font-bold mb-2">{s.title}</h3>
              <p className="text-white/80">{s.description}</p>
            </div>
          ))}
        </div>
      </section>
    </>
  );
}
