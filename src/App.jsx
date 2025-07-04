import ParticlesBackground from './components/ParticlesBackground';
import DarkToggle from './components/DarkToggle';
import { motion, useInView } from 'framer-motion';
import MobileMenu from './components/MobileMenu';
import React, { useRef } from 'react'
import { images } from './data/mediaList'
import Gallery from './components/Gallery'
import BaroccoSection from './components/BaroccoSection'
import Testimonials from './components/Testimonials'

export default function App() {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true });
  return (
    <div className="flex flex-col min-h-screen bg-ivory text-noir">
      <ParticlesBackground className="absolute inset-0 -z-10" />
      {/* NAVBAR */}
<nav role="navigation" aria-label="Navigation principale" className="fixed inset-x-0 top-0 z-50 bg-black/70 backdrop-blur-md">
        <div className="max-w-6xl mx-auto flex items-center justify-between py-4 px-6">
          <span className="text-3xl font-bold text-gold">LuxeEvents</span>
          <ul className="flex space-x-6 uppercase text-ivory tracking-wider">
            {['HOME','#hero','GALERIE','#gallery','HAUTE COUTURE','#barocco','TÉMOIGNAGES','#testimonials']
              .reduce((a, v, i) => (i % 2 === 0 ? a.concat([[v, images]]) : a[a.length - 1].push(v) && a), [])
              .map(([label, href]) => (
                <li key={label}>
                  <a href={href} className="hover:text-gold transition">
                    {label}
                  </a>
                </li>
              ))}
          </ul>
        <li><DarkToggle/></li>
        <MobileMenu />
        </div>
      </nav>

      {/* HERO */}
      <section id="hero" className="relative flex-1 flex items-center justify-center pt-24">
        <div className="text-center">
          <h1 className="text-6xl font-bold mb-6">Bienvenue chez LuxeEvents</h1>
          <a
            href="#gallery"
            className="inline-block px-8 py-4 bg-gold text-noir font-semibold uppercase rounded-full shadow-lg hover:scale-105 transition"
          >
            DÉCOUVRIR LA GALERIE
          </a>
        </div>
      </section>

      <main className="flex-shrink-0">
        {/* GALERIE */}
<motion.section ref={ref} initial={{opacity:0,y:30}} animate={inView?{opacity:1,y:0}:{}} transition={{duration:0.6}} className="py-20 max-w-6xl mx-auto px-6" id="gallery">
          <h2 className="text-4xl font-bold text-center mb-12">Galerie</h2>
          <Gallery images={images} />
        </motion.section>

        {/* HAUTE COUTURE */}
        <BaroccoSection />

        {/* TÉMOIGNAGES */}
        <section id="testimonials" className="py-20 bg-ivory">
          <h2 className="text-4xl font-bold text-center mb-12">Témoignages</h2>
          <Testimonials />
        </section>
      </main>

      {/* FOOTER */}
      <footer className="mt-auto bg-noir text-ivory py-8">
        <div className="max-w-6xl mx-auto text-center text-sm font-sans">
          © {new Date().getFullYear()} LuxeEvents – Tous droits réservés
        </div>
      </footer>
    </div>
  )
}
