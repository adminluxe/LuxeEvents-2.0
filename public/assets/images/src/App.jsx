import React from 'react'
import Hero from './components/Hero'
import Gallery from './components/Gallery'
import Videos from './components/Videos'
import WhyChooseUs from './components/WhyChooseUs'
import Testimonials from './components/Testimonials'
import Contact from './components/Contact'

export default function App() {
  return (
    <div className="font-sans antialiased text-gray-900">
      {/* Hero full-screen */}
      <Hero />

      {/* Galerie photo */}
      <Gallery />

      {/* Bibliothèque vidéo */}
      <Videos />

      {/* Pourquoi nous choisir */}
      <WhyChooseUs />

      {/* Témoignages */}
      <Testimonials />

      {/* Formulaire de contact */}
      <Contact />

      {/* Footer minimaliste */}
      <footer className="py-8 bg-luxeBlack text-center text-white">
        <p className="text-sm">&copy; {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</p>
      </footer>
    </div>
  )
}
