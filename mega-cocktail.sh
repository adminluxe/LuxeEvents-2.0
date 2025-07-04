#!/usr/bin/env bash
set -e

# 1) ENRICHISSEMENT DE LA LIGHTBOX
tee src/components/Lightbox.jsx << 'EOF'
import React, { useState } from 'react'
import Modal from 'react-modal'
import { motion } from 'framer-motion'

Modal.setAppElement('#root')

export default function Lightbox({ src, alt, siblings = [], currentIndex = 0, onNavigate }) {
  const [open, setOpen] = useState(false)
  const [index, setIndex] = useState(currentIndex)

  const next = () => setIndex((i) => (i + 1) % siblings.length)
  const prev = () => setIndex((i) => (i - 1 + siblings.length) % siblings.length)

  return (
    <>
      <img src={src} alt={alt} className="cursor-pointer" onClick={() => setOpen(true)} />
      <Modal
        isOpen={open}
        onRequestClose={() => setOpen(false)}
        className="fixed inset-0 flex items-center justify-center bg-black/90 p-4"
      >
        <motion.img
          key={siblings[index]}
          src={siblings[index]}
          alt={`${alt} ${index+1}`}
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.4 }}
          className="max-h-full max-w-full"
        />
        <button onClick={prev} className="absolute left-4 top-1/2 text-ivory text-4xl">‹</button>
        <button onClick={next} className="absolute right-4 top-1/2 text-ivory text-4xl">›</button>
        <div className="absolute bottom-8 flex space-x-2">
          {siblings.map((s, i) => (
            <img
              key={s}
              src={s}
              alt=""
              className={`w-16 h-10 object-cover rounded ${i===index?'ring-2 ring-gold':''}`}
              onClick={() => setIndex(i)}
            />
          ))}
        </div>
      </Modal>
    </>
  )
}
EOF

# 2) MENU MOBILE “HAUTE COUTURE” : logo pivotant
tee src/components/MobileMenu.jsx << 'EOF'
import { useState } from 'react'
import { Dialog } from '@headlessui/react'
import { Menu, X } from 'lucide-react'

export default function MobileMenu() {
  let [open, setOpen] = useState(false)
  return (
    <>
      <button onClick={() => setOpen(true)} className="md:hidden p-2">
        <Menu className="text-ivory" />
      </button>
      <Dialog open={open} onClose={() => setOpen(false)} className="fixed inset-0 z-50">
        <Dialog.Overlay className="fixed inset-0 bg-black/70" />
        <div className="relative bg-ivory w-3/4 max-w-xs h-full p-6 shadow-xl transform transition-transform duration-500 ease-in-out"
             style={{ transform: open ? 'translateX(0)' : 'translateX(-100%)' }}>
          <div className="flex justify-between items-center mb-8">
            <div className={`text-3xl font-bold text-gold transition-transform duration-500 ${open?'rotate-360':''}`}>✨</div>
            <button onClick={() => setOpen(false)}>
              <X />
            </button>
          </div>
          <nav className="flex flex-col space-y-6 uppercase text-noir font-bold">
            {[
              ['Home', '#hero'],
              ['Galerie', '#gallery'],
              ['Haute Couture', '#barocco'],
              ['Témoignages', '#testimonials'],
            ].map(([label, href]) => (
              <a key={label} href={href} className="hover:text-gold transition">
                {label}
              </a>
            ))}
          </nav>
        </div>
      </Dialog>
    </>
  )
}
EOF

# 3) ACCESSIBILITÉ & ARIA : rôles et focus
sed -i "s|<nav |<nav role=\"navigation\" aria-label=\"Menu principal\" |" src/App.jsx
sed -i "/@tailwind utilities/a\\
:focus { outline: 3px solid #D4AF37; outline-offset: 2px; }" src/index.css

# 4) PWA – configuration Workbox et splash
npm install -D vite-plugin-pwa
sed -i "/import { VitePWA }/d" vite.config.js
sed -i "1i import { VitePWA } from 'vite-plugin-pwa';" vite.config.js
sed -i "/plugins: \[/a \
    VitePWA({ \
      registerType: 'autoUpdate', \
      manifest: { \
        name: 'LuxeEvents', short_name: 'Luxe', \
        theme_color: '#D4AF37', background_color: '#FFFFF0', \
        icons:[{src:'/favicon-gold-192.png',sizes:'192x192',type:'image/png'},{src:'/favicon-gold-512.png',sizes:'512x512',type:'image/png'}], \
        splash_pages: 'all' \
      } \
    })," vite.config.js

# 5) SEO & preload du Hero 3D
sed -i "/<head>/a\
  <link rel=\"preload\" href=\"/hero-3d.glb\" as=\"fetch\" crossorigin />" index.html

# 6) ANIMATIONS AVANCÉES SCROLL-TRIGGERED + PARTICULES
tee src/hooks/useScrollAnim.js << 'EOF'
import { useRef, useEffect } from 'react'
export function useScrollAnim(callback, options={}) {
  const ref = useRef(null)
  useEffect(() => {
    const obs = new IntersectionObserver(([e]) => { if(e.isIntersecting) callback(ref.current) }, options)
    if (ref.current) obs.observe(ref.current)
    return () => obs.disconnect()
  }, [])
  return ref
}
EOF
sed -i "1i import { useScrollAnim } from './hooks/useScrollAnim';" src/components/BaroccoSection.jsx
sed -i "/<section id=\"barocco\"/a\\
  ref={useScrollAnim((el)=>el.classList.add('animate-pulse'),{threshold:0.3})}" src/components/BaroccoSection.jsx

echo "✅ Toutes les fonctionnalités Haute Couture ont été injectées ! Relance ton serveur : npm run dev"
