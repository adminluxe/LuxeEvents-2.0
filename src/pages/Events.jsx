import React, { useState, useEffect } from 'react';
export default function Events() {
  const [events, setEvents] = useState([]);
  useEffect(() => {
    fetch(import.meta.env.VITE_BACKEND_URL + '/events')
      .then((res) => res.json())
      .then(setEvents);
  }, []);
  return (
    <section className="mt-16">
      <h2 className="text-3xl font-bold">Événements à venir</h2>
      <ul className="mt-6 space-y-4">
        {events.map((e) => (
          <li key={e.id} className="p-4 border rounded-lg">
            <h3 className="text-2xl">{e.title}</h3>
            <p className="text-gray-600">{new Date(e.date).toLocaleDateString()}</p>
          </li>
        ))}
      </ul>
    </section>
  );
}
