import React from 'react';
export default function ServicesGrid() {
  const services = ["Conception d'événements", "Coordination", "Décoration", "Catering"];
  return (
    <section className="mt-16 grid grid-cols-1 md:grid-cols-2 gap-8">
      {services.map((s) => (
        <div key={s} className="p-6 border rounded-lg hover:shadow-lg">
          <h3 className="text-2xl font-semibold">{s}</h3>
          <p className="mt-2 text-gray-600">Description courte pour {s}.</p>
        </div>
      ))}
    </section>
  );
}
