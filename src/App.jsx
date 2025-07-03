import Hero from './components/Hero'
import Gallery from './components/Gallery'
import Testimonials from './components/Testimonials'

export default function App() {
  return (
    <div className="App font-sans">
      {/* — Navigation simple — */}
      <nav className="fixed top-0 left-0 right-0 bg-white/80 backdrop-blur p-4 flex justify-center space-x-6 z-10">
        <a href="#hero" className="hover:underline">Accueil</a>
        <a href="#gallery" className="hover:underline">Galerie</a>
        <a href="#testimonials" className="hover:underline">Témoignages</a>
      </nav>

      {/* — Hero avec bouton d’ancrage — */}
      <section id="hero" className="relative">
        <Hero />
        <div className="absolute bottom-10 w-full text-center">
          <a
            href="#gallery"
            className="inline-block bg-gold-500 text-white py-3 px-6 rounded-full shadow-lg hover:bg-gold-600 transition"
          >
            Découvrir la galerie
          </a>
        </div>
      </section>

      {/* — Galerie d’images — */}
      <section id="gallery" className="pt-32 pb-16 px-8">
        <h2 className="text-3xl font-bold text-center mb-8">Galerie d’Exception</h2>
        <Gallery />
      </section>

      {/* — Témoignages — */}
      <section id="testimonials" className="bg-gray-100 py-16 px-8">
        <h2 className="text-3xl font-bold text-center mb-8">Ce qu’en disent nos clients</h2>
        <Testimonials />
      </section>

      {/* — Footer — */}
      <footer className="text-center py-6 text-sm text-gray-500">
        © 2025 LuxeEvents. Tous droits réservés.
      </footer>
    </div>
  )
}
