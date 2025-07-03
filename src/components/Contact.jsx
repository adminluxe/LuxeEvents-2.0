import { useState } from 'react';
import axios from 'axios';
import { motion } from 'framer-motion';

export default function Contact() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [msg, setMsg] = useState('');
  const [loading, setLoading] = useState(false);
  const [reply, setReply] = useState('');

  const send = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await axios.post(import.meta.env.VITE_API_URL + '/contact', { name, email, message: msg });
      setReply('Merci ! Nous reviendrons vers vous sous 24h.');
    } catch {
      setReply('Oups… un problème est survenu, réessayez.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <section className="py-16 px-4 bg-white">
      <h2 className="text-4xl font-serif text-center mb-8">Contactez-Nous</h2>
      <div className="max-w-2xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-8">
        <form role="region" aria-label="Formulaire de contact" onSubmit={send} className="flex flex-col gap-4">
          <input
            type="text"
            required
            placeholder="Votre nom"
            className="p-2 border rounded"
            onChange={(e) => setName(e.target.value)}
          />
          <input
            type="email"
            required
            placeholder="Votre email"
            className="p-2 border rounded"
            onChange={(e) => setEmail(e.target.value)}
          />
          <textarea
            required
            rows={4}
            placeholder="Votre message…"
            className="p-2 border rounded resize-none"
            onChange={(e) => setMsg(e.target.value)}
          />
          <motion.button
            type="submit"
            disabled={loading}
            whileTap={{ scale: 0.95 }}
            className="bg-luxeGold text-luxeBlack py-2 rounded-full uppercase font-semibold"
          >
            {loading ? 'Envoi…' : 'Envoyer'}
          </motion.button>
          {reply && <p className="mt-2 text-center text-gray-700">{reply}</p>}
        </form>
        <div className="h-80 w-full overflow-hidden rounded-lg shadow-lg">
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18…"
            className="w-full h-full border-0"
            loading="lazy"
          ></iframe>
        </div>
      </div>
    </section>
  );
}
