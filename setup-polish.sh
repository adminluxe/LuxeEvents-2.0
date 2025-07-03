#!/usr/bin/env bash
set -euo pipefail

echo "✨ Démarrage du polish final LuxeEvents…"

# 1) Installation des dépendances SEO & lazyload
echo "1) Installation de react-helmet-async et react-lazyload…"
npm install react-helmet-async react-lazyload

# 2) Mise en place de HelmetProvider et LazyLoad globalement
echo "2) Patch src/main.jsx pour HelmetProvider et LazyLoad…"
perl -i -0777 -pe '
  s|import { BrowserRouter as Router, Routes, Route } from "react-router-dom";|import { BrowserRouter as Router, Routes, Route } from "react-router-dom";\nimport { HelmetProvider } from "react-helmet-async";|s;
  s|<Router>|<HelmetProvider><Router>|s;
  s|</Router>|</Router></HelmetProvider>|s;
' src/main.jsx

# 3) Ajout de meta tags par défaut dans App (Layout)
echo "3) Création de src/components/Layout.jsx avec meta tags…"
tee src/components/Layout.jsx > /dev/null << 'EOF'
import React from 'react'
import { Helmet } from 'react-helmet-async'

export default function Layout({ children }) {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – L’Exception sur mesure</title>
        <meta name="description" content="Vivez l’Exception avec nos expériences exclusives : cocktails, jazz, banquets royaux…" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Helmet>
      {children}
    </>
  )
}
EOF

# 4) Wrap pages in Layout
echo "4) Mise à jour de src/routes.jsx pour utiliser Layout…"
perl -i -0777 -pe '
  s|<Routes>|import Layout from "./components/Layout";\n\n<Routes>|s;
  s|element={<([^>]+)>|element={<Layout><\1>|g;
  s|/></Route>|/></\1></Layout></Route>|g;
' src/routes.jsx

# 5) Lazy-load des images dans GalleryDetail & Testimonials
echo "5) Ajout de LazyLoad dans GalleryDetail.jsx et Testimonials.jsx…"
perl -i -0777 -pe '
  s|import Slider from "react-slick"|import Slider from "react-slick";\nimport LazyLoad from "react-lazyload"|s;
  s|<img\s+src=|<LazyLoad><img src=|g;
  s|className="w-full h-96|className="w-full h-96" /></LazyLoad>|g;
' src/components/landing/GalleryDetail.jsx

perl -i -0777 -pe '
  s|<img src={attributes.photo.data.attributes.url}|<LazyLoad><img src={attributes.photo.data.attributes.url}|s;
  s|className="w-24|className="w-24" /></LazyLoad>|g;
  s|import React from "react"|import React from "react";\nimport LazyLoad from "react-lazyload"|s;
' src/components/landing/Testimonials.jsx

# 6) Animations supplémentaires Framer Motion sur les pages clés
echo "6) Enrobage des sections principales avec motion.div…"
perl -i -0777 -pe '
  s|import React from "react"|import React from "react";\nimport { motion } from "framer-motion"|s;
  s|<div className="mx-auto max-w-4xl p-4">|<motion.div className="mx-auto max-w-4xl p-4" initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>|s;
  s|</div>|</motion.div>|s;
' src/components/landing/GalleryDetail.jsx

# 7) Vérification
echo "✅ Polish final terminé !"
echo "→ Relance : npm run dev -- --host et admire les animations, le lazy-loading et le SEO au top."

