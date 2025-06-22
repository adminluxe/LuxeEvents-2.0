import React from 'react';
export default function Contact() {
  return (
    <section className="mt-16">
      <h2 className="text-3xl font-bold">Contactez-nous</h2>
      <form className="mt-6 space-y-4">
        <input type="text" placeholder="Votre nom" className="w-full p-3 border rounded" />
        <input type="email" placeholder="Votre email" className="w-full p-3 border rounded" />
        <textarea placeholder="Votre message" className="w-full p-3 border rounded" />
        <button type="submit" className="px-6 py-3 bg-black text-white rounded">Envoyer</button>
      </form>
    </section>
  );
}
