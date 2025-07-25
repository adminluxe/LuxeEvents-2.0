#!/bin/bash

echo "🛠 Correction complète de src/App.jsx..."

cat << 'EOL' > src/App.jsx
import React from 'react'
import { Routes, Route } from 'react-router-dom'

// Pages
import HomePage from './pages/HomePage'
import DevisPage from './pages/devis'
import LegalPage from './pages/Legal'
import CorporatePage from './pages/corporate'
import MariagePage from './pages/mariage'
import CulturelPage from './pages/culturel'
import ServicesPage from './pages/ServicesPage'
import MediaPage from './pages/MediaPage'
import RequestQuotePage from './pages/RequestQuotePage'

// Audio et Animations
import AudioAmbient from './components/AudioAmbient'
import IntroAnimationLottie from './components/IntroAnimationLottie'

function App() {
  return (
    <>
      <AudioAmbient />
      <IntroAnimationLottie />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/devis" element={<DevisPage />} />
        <Route path="/mentions-legales" element={<LegalPage />} />
        <Route path="/corporate" element={<CorporatePage />} />
        <Route path="/mariage" element={<MariagePage />} />
        <Route path="/culturel" element={<CulturelPage />} />
        <Route path="/services" element={<ServicesPage />} />
        <Route path="/media" element={<MediaPage />} />
        <Route path="/quote" element={<RequestQuotePage />} />
        <Route path="*" element={<HomePage />} />
      </Routes>
    </>
  )
}

export default App
EOL

echo "✅ src/App.jsx réparé proprement."
