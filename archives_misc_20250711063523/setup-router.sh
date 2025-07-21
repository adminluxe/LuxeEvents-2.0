#!/usr/bin/env bash
set -e

# 1) Installer react-router-dom
echo "📦 Installation de react-router-dom…"
pnpm add react-router-dom

# 2) Créer src/main.jsx
echo "✍️  Écriture de src/main.jsx"
cat > src/main.jsx << 'EOF'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import { BrowserRouter } from 'react-router-dom'

import './index.css' // si tu as un fichier global de styles

ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
)
EOF

# 3) Créer src/App.jsx
echo "✍️  Écriture de src/App.jsx"
cat > src/App.jsx << 'EOF'
import React from 'react'
import { Routes, Route, Link } from 'react-router-dom'

// Import de tes pages existantes
import Home from './Home.jsx'
import About from './About.jsx'
import Contact from './Contact.jsx'
import Events from './Events.jsx'
import Gallery from './Gallery.jsx'
import Prices from './Prices.jsx'
import Services from './Services.jsx'

export default function App() {
  return (
    <div>
      <nav style={{ padding: '1rem', borderBottom: '1px solid #ccc' }}>
        <Link to="/" style={{ marginRight: '1rem' }}>Accueil</Link>
        <Link to="/about" style={{ marginRight: '1rem' }}>À propos</Link>
        <Link to="/events" style={{ marginRight: '1rem' }}>Événements</Link>
        <Link to="/gallery" style={{ marginRight: '1rem' }}>Galerie</Link>
        <Link to="/prices" style={{ marginRight: '1rem' }}>Tarifs</Link>
        <Link to="/services" style={{ marginRight: '1rem' }}>Services</Link>
        <Link to="/contact">Contact</Link>
      </nav>

      <main style={{ padding: '1rem' }}>
        <Routes>
          <Route path="/"        element={<Home />} />
          <Route path="/about"   element={<About />} />
          <Route path="/events"  element={<Events />} />
          <Route path="/gallery" element={<Gallery />} />
          <Route path="/prices"  element={<Prices />} />
          <Route path="/services"element={<Services />} />
          <Route path="/contact" element={<Contact />} />
          {/* Fallback : renvoie à l'accueil */}
          <Route path="*"        element={<Home />} />
        </Routes>
      </main>
    </div>
  )
}
EOF

# 4) Vérification rapide
echo "✅ setup-router.sh a terminé. Voici l’arborescence :"
ls -1 src/{main.jsx,App.jsx}

echo "
👉 Maintenant :
  • Vérifie que tes composants Home.jsx, About.jsx, etc. exportent bien un default React.
  • Relance le build : pnpm run build
  • Déploie : vercel build --prod --yes && vercel --prebuilt --prod --yes
  • Teste /, /about, /contact, etc. : le router client doit fonctionner sans 404.
"
