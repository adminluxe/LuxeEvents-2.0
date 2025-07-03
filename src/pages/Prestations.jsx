import React from 'react'
import { useInView } from "react-intersection-observer";
import { motion } from "framer-motion";
import { useInView } from "react-intersection-observer";
import { useInView } from "react-intersection-observer";
import { motion } from "framer-motion";
import { useInView } from "react-intersection-observer";
import Button from '../components/ui/Button'
import { motion } from "framer-motion"
import { motion } from "framer-motion"

export default function Prestations() {
  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });

  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });
  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });
  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });
  const offers = [
    {
      title: 'Mariages & Cérémonies',
      desc: 'Coordination parfaite, décor sur-mesure et moments empreints d’émotion.',
    },
    { 
      title: 'Soirées Privées',
      desc: 'Ambiance raffinée, DJs & artistes de renom, scénographie immersive.',
    },
    { 
      title: 'Événements d’Entreprise',
      desc: 'Séminaires, lancements de produits et galas clés-en-main. Impact garanti.',
    },
  ]

  return (<motion.div ref={ref} initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}}>
  (
    <motion.div ref={ref} initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}}>
    <div className="mx-auto max-w-4xl p-6 space-y-8">
      <h1 className="text-4xl font-bold text-center">Nos Prestations</h1>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {offers.map(o => (
          <div
            key={o.title}
            className="bg-white rounded-lg shadow p-6 hover:scale-105 transition"
          >
            <h2 className="text-2xl font-semibold mb-2">{o.title}</h2>
            <p className="text-gray-600">{o.desc}</p>
          </motion.div>
        ))}
      </motion.div>
      <div className="text-center mt-8">
        <Button onClick={() => (window.location.href = '/contact')}>
          Contactez-nous
        </Button>
      </motion.div>
    </motion.div>
  )
}
