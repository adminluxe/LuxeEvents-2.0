#!/usr/bin/env bash
set -e

echo "🚀 1. Création du composant Navbar avec drawer, theme-switcher et ARIA…"
mkdir -p src/components
cat > src/components/Navbar.jsx << 'EOF'
import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false)
  const [theme, setTheme] = useState('light')
  useEffect(() => {
    document.documentElement.classList.toggle('dark', theme==='dark')
  }, [theme])
  return (
    <header className="fixed w-full z-20 bg-white bg-opacity-80 backdrop-blur-md dark:bg-gray-900 dark:bg-opacity-80">
      <nav className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-between h-16">
        <Link to="/" className="flex-shrink-0">
          <img src="/logo.svg" alt="LuxeEvents Logo" className="h-8 w-auto"/>
        </Link>
        <div className="hidden md:flex space-x-6">
          <Link to="/" className="text-gray-800 dark:text-gray-200 hover:text-indigo-600">Accueil</Link>
          <Link to="/services" className="text-gray-800 dark:text-gray-200 hover:text-indigo-600">Services</Link>
          <Link to="/media" className="text-gray-800 dark:text-gray-200 hover:text-indigo-600">Médias</Link>
          <Link to="/demande-de-devis" className="text-gray-800 dark:text-gray-200 hover:text-indigo-600">Devis</Link>
        </div>
        <div className="hidden md:flex items-center space-x-4">
          <button onClick={()=>setTheme(theme==='light'?'dark':'light')} aria-label="Switch theme">
            {theme==='light'?'🌙':'☀️'}
          </button>
          <Link to="/demande-de-devis" className="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-md">Demandez un devis</Link>
        </div>
        <button className="md:hidden" onClick={()=>setIsOpen(!isOpen)} aria-controls="mobile-menu" aria-expanded={isOpen}>
          <svg className="h-6 w-6 text-gray-800 dark:text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d={
              isOpen
              ? 'M6 18L18 6M6 6l12 12'
              : 'M4 6h16M4 12h16M4 18h16'
            }/>
          </svg>
        </button>
      </nav>
      {isOpen && (
        <div id="mobile-menu" className="md:hidden bg-white dark:bg-gray-900 shadow-lg">
          <Link to="/" className="block px-4 py-2 text-gray-800 dark:text-gray-200 hover:bg-indigo-50">Accueil</Link>
          <Link to="/services" className="block px-4 py-2 text-gray-800 dark:text-gray-200 hover:bg-indigo-50">Services</Link>
          <Link to="/media" className="block px-4 py-2 text-gray-800 dark:text-gray-200 hover:bg-indigo-50">Médias</Link>
          <Link to="/demande-de-devis" className="block px-4 py-2 text-gray-800 dark:text-gray-200 hover:bg-indigo-50">Devis</Link>
          <button onClick={()=>setTheme(theme==='light'?'dark':'light')} className="block w-full text-left px-4 py-2">Toggle Theme</button>
        </div>
      )}
    </header>
EOF

echo "📄 2. Création des pages et routage dans src/App.jsx…"
mkdir -p src/pages
# Home.jsx
cat > src/pages/Home.jsx << 'EOF'
import React from 'react'
import UIPreview from '../UIPreview'
export default function Home() {
  return <UIPreview/>
}
EOF
# RequestQuotePage.jsx
cat > src/pages/RequestQuotePage.jsx << 'EOF'
import React from 'react'
export default function RequestQuotePage() {
  return (
    <div className="pt-20 text-center">
      <h1 className="text-3xl font-semibold mb-4">Demande de devis</h1>
      <p>Formulaire de contact à venir…</p>
    </div>
  )
}
EOF
# MediaPage.jsx placeholder with empty Carousel
cat > src/pages/MediaPage.jsx << 'EOF'
import React from 'react'
export default function MediaPage() {
  return (
    <div className="pt-20 text-center">
      <h1 className="text-3xl font-semibold mb-4">Médias</h1>
      <div className="max-w-xl mx-auto">
        {/* TODO: Intégrer ici votre composant Carousel */}
        <p>Carousel de vos plus beaux visuels.</p>
      </div>
    </div>
  )
}
EOF
# Footer.jsx
cat > src/components/Footer.jsx << 'EOF'
import React from 'react'
export default function Footer() {
  return (
    <footer className="bg-gray-100 dark:bg-gray-800 py-8 mt-20">
      <div className="max-w-7xl mx-auto px-4 text-center text-gray-600 dark:text-gray-400">
        <p>© {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</p>
        <div className="mt-4 space-x-4">
          <a href="/politique-confidentialite">Politique RGPD</a>
          <a href="https://instagram.com">Instagram</a>
          <a href="https://facebook.com">Facebook</a>
        </div>
      </div>
    </footer>
  )
}
EOF

cat > src/App.jsx << 'EOF'
import React from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
import Home from './pages/Home'
import MediaPage from './pages/MediaPage'
import RequestQuotePage from './pages/RequestQuotePage'
import './i18n'
export default function App() {
  return (
    <BrowserRouter>
      <Navbar/>
      <main className="pt-16">
        <Routes>
          <Route path="/" element={<Home/>}/>
          <Route path="/media" element={<MediaPage/>}/>
          <Route path="/demande-de-devis" element={<RequestQuotePage/>}/>
        </Routes>
      </main>
      <Footer/>
    </BrowserRouter>
  )
}
EOF

echo "✨ 3. Stub palette & couleurs officielles…"
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html','./src/**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        luxeGold: '#D4AF37',
        luxeBlack: '#1F2937',
        luxeIvory: '#F5F5DC'
      }
    }
  },
  plugins: []
}
EOF

echo "🧰 4. Rappels PWA & Accessibilité :"
cat << NOTES

✔️ Vérifiez dans DevTools → Application → Manifest :
   • manifest.webmanifest (ou manifest.json) doit contenir votre id, icônes & screenshots.

✔️ DevTools → Application → Service Workers :
   • cochez “Update on reload”
   • testez le handler fetch offline.

✔️ Test “Add to home screen” sur un mobile ou émulateur.

✔️ Lancez un audit Lighthouse (PWA & Accessibilité).

✔️ Ajustez vos composants (espace, typo, ARIA, contrastes, etc.).

Notes :
- Votre palette officielle est maintenant dispo en Tailwind via 
  text-luxeGold bg-luxeBlack border-luxeIvory etc.
- Les pages bilingues utilisent \`useTranslation()\` si besoin.
- Le theme-switcher clair/sombre est dans la Navbar.
- Le footer contient un lien RGPD + réseaux sociaux.

Bonne itération vers V3 ! 🌟

NOTES
EOF

echo "🔧 5. Installation des dépendances manquantes…"
pnpm add react-router-dom i18next-http-backend
pnpm install

echo "✅ Bootstrap V3 terminé. Relance ton dev : pnpm run dev"
