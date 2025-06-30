#!/usr/bin/env bash
set -e

# 1. Installer les dépendances
npm install react-router-dom framer-motion

# 2. Mettre à jour tailwind.config.cjs
cat > tailwind.config.cjs << 'TWC'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html','./src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
        luxeGold:   '#C9A66B',
        luxeBlack:  '#1A1A1A',
        gold:       '#D4AF37',
        yellow:     '#FFD700',
        ivory:      '#F7F1E1',
        luxeWhite:  '#FFFFFF',
      },
      backgroundImage: {
        'site-hero': "url('/assets/image1.jpg')",
      },
      fontFamily: {
        serif: ['Playfair Display','serif'],
        sans:  ['Inter','sans-serif'],
      },
    },
  },
  plugins: [ require('@tailwindcss/typography') ],
}
TWC

# 3. Créer les composants et pages
mkdir -p src/components src/pages
cat > src/components/Navbar.jsx << 'NAV'
import { Link } from 'react-router-dom'
export default function Navbar() {
  return (
    <nav className="fixed top-0 w-full bg-black/50 backdrop-blur-md z-50">
      <div className="max-w-7xl mx-auto flex justify-between items-center p-4">
        <Link to="/" className="text-luxeGold text-2xl font-serif">LuxeEvents</Link>
        <div className="space-x-6 text-luxeWhite">
          <Link to="/reserver"     className="hover:text-gold">Réserver</Link>
          <Link to="/moments"      className="hover:text-gold">Moments</Link>
          <Link to="/temoignages"  className="hover:text-gold">Témoignages</Link>
          <Link to="/contact"      className="hover:text-gold">Contact</Link>
        </div>
      </div>
    </nav>
  )
}
NAV

cat > src/components/Hero.jsx << 'HERO'
import { Link } from 'react-router-dom'
import { motion } from 'framer-motion'
export default function Hero() {
  return (
    <section className="relative h-screen overflow-hidden">
      <video src="/assets/hero-loop.mp4" className="absolute inset-0 w-full h-full object-cover" autoPlay loop muted playsInline/>
      <div className="absolute inset-0 bg-black/40"></div>
      <motion.div initial={{opacity:0,y:20}} animate={{opacity:1,y:0}} transition={{delay:0.5}} className="relative z-10 max-w-3xl mx-auto text-center text-luxeWhite p-4">
        <h1 className="text-5xl font-serif mb-4">Offrez l’Exception</h1>
        <p className="mb-6">Une expérience inoubliable où chaque détail respire le luxe.</p>
        <Link to="/reserver" className="bg-gold hover:bg-yellow text-luxeBlack font-bold py-3 px-6 rounded-full">Réservez maintenant</Link>
      </motion.div>
    </section>
  )
}
HERO

cat > src/components/Gallery.jsx << 'GALL'
import React from 'react'
const images = ['/assets/image1.jpg','/assets/image10.jpg','/assets/image11.png','/assets/image12.jpg']
export default function Gallery() {
  return (
    <section className="py-16 bg-ivory bg-opacity-80 rounded-lg">
      <h2 className="text-3xl font-serif text-luxeGold mb-8 text-center">Moments d’Exception</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
        {images.map((src,i)=><div key={i} className="overflow-hidden rounded-lg shadow-lg"><img src={src} alt={\`Moment \${i+1}\`} className="w-full h-48 object-cover hover:scale-105 transition-transform duration-300"/></div>)}
      </div>
    </section>
  )
}
GALL

cat > src/components/Testimonials.jsx << 'TEST'
import { useState,useEffect } from 'react'
const data=[
  {quote:"Une expérience hors du commun, chaque détail était parfait.",author:"Élise Martin"},
  {quote:"Un service VIP, des émotions sans limite, je recommande !",author:"Julien Dubois"},
  {quote:"LuxeEvents a redéfini mes attentes, sublime et innovant.",author:"Camille Lefèvre"}
]
export default function Testimonials() {
  const [i,setI]=useState(0)
  useEffect(()=>{
    const id=setInterval(()=>setI(i=> (i+1)%data.length),10000)
    return()=>clearInterval(id)
  },[])
  const {quote,author}=data[i]
  return (
    <section className="py-16 bg-ivory">
      <blockquote className="max-w-2xl mx-auto text-center italic text-xl">“{quote}”<footer className="mt-4 font-semibold">— {author}</footer></blockquote>
    </section>
  )
}
TEST

cat > src/components/ContactForm.jsx << 'CF'
import { useState } from 'react'
export default function ContactForm(){
  const [f,setF]=useState({name:'',email:'',msg:''})
  return (
    <div className="py-16 px-4 max-w-xl mx-auto bg-ivory rounded-lg shadow-lg">
      <h2 className="text-4xl font-serif mb-8 text-center">Contactez-nous</h2>
      <form onSubmit={e=>{e.preventDefault();alert('Envoyé !')}} className="space-y-6">
        {['name','email','msg'].map((k,i)=>(
          <div key={i} className="relative">
            <textarea id={k} rows={k==='msg'?4:1} value={f[k]} onChange={e=>setF({...f,[k]:e.target.value})} required className="peer w-full p-4 border rounded focus:outline-none focus:ring focus:border-gold"/>
            <label htmlFor={k} className="absolute left-4 top-4 text-gray-400 peer-focus:top-1 peer-focus:text-sm peer-focus:text-gold transition-all">{k==='msg'?'Votre message…':\`Votre \${k}\`}</label>
          </div>
        ))}
        <button type="submit" className="w-full bg-gold hover:bg-yellow text-luxeBlack font-bold py-3 rounded">ENVOYER</button>
      </form>
    </div>
  )
}
CF

# 4. Créer les pages vides
for name in Reserve GalleryDetail TestimonialsPage ContactPage; do
  title=$(case $name in
    Reserve) echo "Réserver un événement" ;;
    GalleryDetail) echo "Moments d’Exception" ;;
    TestimonialsPage) echo "Ils ont vécu l’Exception" ;;
    ContactPage) echo "Contactez-nous" ;;
  esac)
  cat > src/pages/$name.jsx << PAGE
import React from 'react'
export default function $name(){
  return(<div className="p-8"><h2 className="text-4xl font-serif mb-4">$title</h2><p>Contenu à venir…</p></div>)
}
PAGE
done

# 5. Mettre à jour main et routes
cat > src/main.jsx << 'MAIN'
import React from 'react'
import ReactDOM from 'react-dom/client'
import './index.css'
import { BrowserRouter } from 'react-router-dom'
import App from './App'
ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter><App/></BrowserRouter>
)
MAIN

cat > src/routes.jsx << 'RT'
import React from 'react'
import { Routes,Route } from 'react-router-dom'
import App from './App'
import Reserve from './pages/Reserve'
import GalleryDetail from './pages/GalleryDetail'
import TestimonialsPage from './pages/TestimonialsPage'
import ContactPage from './pages/ContactPage'
export default function Router(){
  return(
    <Routes>
      <Route path="/" element={<App/>}/>
      <Route path="/reserver" element={<Reserve/>}/>
      <Route path="/moments" element={<GalleryDetail/>}/>
      <Route path="/temoignages" element={<TestimonialsPage/>}/>
      <Route path="/contact" element={<ContactPage/>}/>
    </Routes>
  )
}
RT

# 6. Mettre à jour App.jsx
cat > src/App.jsx << 'APP'
import React from 'react'
import Navbar from './components/Navbar'
import Hero from './components/Hero'
import Gallery from './components/Gallery'
import Testimonials from './components/Testimonials'
import ContactForm from './components/ContactForm'
import { Link } from 'react-router-dom'

export default function App(){
  return(
    <div className="min-h-screen bg-site-hero bg-cover bg-center">
      <Navbar/>
      <main className="px-4 md:px-8 lg:px-16 text-luxeWhite space-y-16 mt-24">
        <Hero/>
        <Link to="/moments"><Gallery/></Link>
        <Link to="/temoignages"><Testimonials/></Link>
        <Link to="/contact"><ContactForm/></Link>
      </main>
    </div>
  )
}
APP

# 7. Commit & push
git add .
git commit -m "feat: v1 immersive with routing, hero video, gallery, testimonials, contact"
git push -u origin main

echo "✅ Déploiement v1 terminé ! Vérifie ta Web Preview sur Vercel."
