#!/bin/bash

FILE="src/components/QuoteForm.jsx"

echo "📋 Correction finale de QuoteForm.jsx (fragment JSX)"

# Réécriture complète et propre
cat << 'EOL' > "$FILE"
import React, { useState } from 'react';

export default function QuoteForm() {
  const [formData, setFormData] = useState({
    nom: '',
    email: '',
    message: '',
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Formulaire soumis :', formData);
    // Ajouter ici un appel à votre backend ou API email
  };

  return (
    <>
      <section className="py-16 px-4 max-w-3xl mx-auto">
        <h2 className="text-2xl md:text-4xl font-semibold mb-6 text-center text-gold">Demande de devis</h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            name="nom"
            value={formData.nom}
            onChange={handleChange}
            placeholder="Votre nom"
            className="w-full p-3 rounded border border-gold bg-white/10 backdrop-blur text-white"
            required
          />
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            placeholder="Votre email"
            className="w-full p-3 rounded border border-gold bg-white/10 backdrop-blur text-white"
            required
          />
          <textarea
            name="message"
            value={formData.message}
            onChange={handleChange}
            placeholder="Votre message"
            className="w-full p-3 rounded border border-gold bg-white/10 backdrop-blur text-white"
            rows="5"
            required
          />
          <button
            type="submit"
            className="bg-gold text-white px-6 py-3 rounded hover:bg-yellow-600 transition"
          >
            Envoyer
          </button>
        </form>
      </section>
    </>
  );
}
EOL

echo "✅ QuoteForm réparé."
echo "🛠 Rebuild final + déploiement imminent..."
npm run build && vercel --prod --force --yes
