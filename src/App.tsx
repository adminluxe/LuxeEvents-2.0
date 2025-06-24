import React from 'react';
import { Button } from '../design-system/components/Button';
import { colors, font } from '../design-system/tokens';
import { motion } from 'framer-motion';

export function App() {
  return (
    <div className="min-h-screen bg-ivory text-black font-body">
      {/* Hero Section */}
      <section
        className="flex flex-col items-center justify-center h-screen bg-hero bg-cover bg-center text-center p-4"
        style={{ fontFamily: font.heading }}
      >
        <motion.h1
          className="text-5xl md:text-7xl mb-4 text-gold"
          initial={{ opacity: 0, y: -50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1 }}
        >
          Luxeevents
        </motion.h1>
        <motion.p
          className="text-xl md:text-2xl max-w-xl mb-8"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5, duration: 1 }}
        >
          L'expérience du luxe, accessible à tous. Découvrez nos événements sur-mesure.
        </motion.p>
        <Button onClick={() => alert('Demo CTA')}>
          Demandez un devis
        </Button>
      </section>

      {/* Services Section */}
      <section className="py-16 px-4 bg-white" style={{ fontFamily: font.heading }}>
        <h2 className="text-4xl text-center text-black mb-12">Nos Services</h2>
        <div className="max-w-5xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8">
          {['Planification', 'Décoration', 'Traiteur'].map((service) => (
            <motion.div
              key={service}
              className="p-6 border rounded-2xl shadow hover:shadow-xl transition-shadow"
              whileHover={{ scale: 1.05 }}
            >
              <h3 className="text-2xl mb-2 text-gold">{service}</h3>
              <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vehicula.
              </p>
            </motion.div>
          ))}
        </div>
      </section>

      {/* Testimonials Section */}
      <section className="py-16 px-4 bg-ivory" style={{ fontFamily: font.body }}>
        <h2 className="text-4xl text-center text-black mb-12">Témoignages</h2>
        <div className="max-w-3xl mx-auto space-y-8">
          {[
            { name: 'Marie', quote: 'Un service exceptionnel, soirée inoubliable !' },
            { name: 'Pierre', quote: 'Professionnels et créatifs, je recommande.' }
          ].map((t, i) => (
            <motion.blockquote
              key={i}
              className="italic text-lg border-l-4 pl-4 border-gold"
              initial={{ opacity: 0 }}
              whileInView={{ opacity: 1 }}
              viewport={{ once: true }}
            >
              "{t.quote}" — <strong>{t.name}</strong>
            </motion.blockquote>
          ))}
        </div>
      </section>

      {/* Contact Section */}
      <section className="py-16 px-4 bg-white" style={{ fontFamily: font.heading }}>
        <h2 className="text-4xl text-center text-black mb-8">Contactez-nous</h2>
        <form className="max-w-lg mx-auto grid gap-4">
          <input
            type="text"
            placeholder="Votre nom"
            className="w-full p-3 border rounded-lg"
          />
          <input
            type="email"
            placeholder="Votre email"
            className="w-full p-3 border rounded-lg"
          />
          <textarea
            placeholder="Votre message"
            rows={4}
            className="w-full p-3 border rounded-lg"
          />
          <Button type="submit">Envoyer</Button>
        </form>
      </section>

      {/* Footer */}
      <footer className="py-6 text-center bg-black text-white" style={{ fontFamily: font.body }}>
        © {new Date().getFullYear()} Luxeevents. Tous droits réservés.
      </footer>
    </div>
  );
}

export default App;
