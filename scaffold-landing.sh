#!/usr/bin/env bash
set -e

# Dossiers
COMP_DIR="src/components/landing"
PAGE_DIR="src/pages"

echo "🛠️  Création des composants landing…"

mkdir -p $COMP_DIR $PAGE_DIR

# 1) Hero.jsx
cat > $COMP_DIR/Hero.jsx << 'EOF'
import React from 'react'
import { Button } from '@/components/ui/button'
import { motion } from 'framer-motion'

export default function Hero() {
  return (
    <motion.section
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 1 }}
      className="relative h-screen bg-cover bg-center"
      style={{ backgroundImage: "url('/hero.jpg')" }}
    >
      <div className="absolute inset-0 bg-black/40 flex flex-col items-center justify-center text-center p-4">
        <h1 className="text-5xl font-serif text-ivory mb-4">Offrez l’Exception</h1>
        <Button onClick={() => window.location.href = '/reserver'} className="px-8 py-4 text-lg">
          Réservez maintenant
        </Button>
      </div>
    </motion.section>
  )
}
EOF

# 2) FeatureCard.jsx
cat > $COMP_DIR/FeatureCard.jsx << 'EOF'
import React from 'react'
import { Card, CardContent } from '@/components/ui/card'
import { motion } from 'framer-motion'

export default function FeatureCard({ title, img, children }) {
  return (
    <motion.div whileHover={{ scale: 1.05 }} className="w-full">
      <Card className="overflow-hidden">
        <img src={img} alt={title} className="w-full h-48 object-cover" loading="lazy" />
        <CardContent className="p-4">
          <h3 className="font-bold mb-2">{title}</h3>
          <p>{children}</p>
        </CardContent>
      </Card>
    </motion.div>
  )
}
EOF

# 3) Testimonials.jsx
cat > $COMP_DIR/Testimonials.jsx << 'EOF'
import React from 'react'
import { motion } from 'framer-motion'

const data = [
  { photo: '/testi1.jpg', quote: 'Un service hors pair !', name: 'Jean Dupont, CEO' },
  { photo: '/testi2.jpg', quote: 'Magie et raffinement.', name: 'Marie Curie, Artiste' },
  { photo: '/testi3.jpg', quote: 'Inoubliable.', name: 'Louis Pasteur, Gastronome' },
]

export default function Testimonials() {
  return (
    <section className="py-16 bg-gray-800 text-ivory">
      <h2 className="text-3xl font-serif text-center mb-8">Ils ont vécu l’Exception</h2>
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-6 px-4">
        {data.map((t,i) => (
          <motion.div key={i} whileHover={{ scale: 1.02 }} className="text-center">
            <img src={t.photo} alt={t.name} className="mx-auto w-24 h-24 rounded-full mb-4 object-cover" loading="lazy" />
            <p className="italic mb-2">“{t.quote}”</p>
            <p className="font-bold">{t.name}</p>
          </motion.div>
        ))}
      </div>
    </section>
  )
}
EOF

# 4) Footer.jsx
cat > $COMP_DIR/Footer.jsx << 'EOF'
import React from 'react'
import { FaInstagram, FaFacebook, FaTwitter } from 'react-icons/fa'

export default function Footer() {
  return (
    <footer className="bg-black text-gray-400 py-8">
      <div className="container mx-auto flex flex-col md:flex-row justify-between items-center px-4">
        <nav className="mb-4 md:mb-0">
          <a href="/" className="mx-2 hover:text-ivory">Accueil</a>
          <a href="/moments" className="mx-2 hover:text-ivory">Moments</a>
          <a href="/reserver" className="mx-2 hover:text-ivory">Réserver</a>
          <a href="/contact" className="mx-2 hover:text-ivory">Contact</a>
        </nav>
        <div className="space-x-4 mb-4 md:mb-0">
          <a href="#"><FaInstagram /></a>
          <a href="#"><FaFacebook /></a>
          <a href="#"><FaTwitter /></a>
        </div>
        <p className="text-sm">&copy; {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</p>
      </div>
    </footer>
  )
}
EOF

# 5) Landing.jsx
cat > $PAGE_DIR/Landing.jsx << 'EOF'
import React from 'react'
import Hero from '../components/landing/Hero'
import FeatureCard from '../components/landing/FeatureCard'
import Testimonials from '../components/landing/Testimonials'
import Footer from '../components/landing/Footer'

export default function Landing() {
  const features = [
    { title: 'Cocktails Signature', img: '/cocktail.jpg', desc: 'Atelier sur-mesure pour vos papilles.' },
    { title: 'Soirée Jazz', img: '/jazz.jpg', desc: 'Ambiance feutrée et notes soul.' },
    { title: 'Banquet Royal', img: '/banquet.jpg', desc: 'Grandeur et raffinement absolus.' },
  ]

  return (
    <>
      <Hero />
      <section className="py-16 grid grid-cols-1 md:grid-cols-3 gap-8 px-4 bg-gray-100">
        {features.map(f =>
          <FeatureCard key={f.title} title={f.title} img={f.img}>
            {f.desc}
          </FeatureCard>
        )}
      </section>
      <Testimonials />
      <Footer />
    </>
  )
}
EOF

echo "✅ Landing scaffolding OK !"
echo "→ Ajoute tes images (/public/hero.jpg, etc.)"
echo "→ Dans src/routes.jsx, remplace la route / par <Route path='/' element={<Landing/>} />"
