#!/usr/bin/env bash
set -euo pipefail

# Sauvegarde de App.jsx
cp src/App.jsx src/App.jsx.bak

# Écriture d'un App.jsx minimal avec Router
cat > src/App.jsx << 'EOF'
import React from 'react'
import { Routes, Route } from 'react-router-dom'
import Home from './pages/index'
import About from './pages/about'
import Contact from './pages/contact'
// ... importe tes autres pages ici

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />
      <Route path="/contact" element={<Contact />} />
      {/* ajoute tes autres routes */}
    </Routes>
  )
}
EOF

chmod +x apply-router-fix.sh
echo "✅ src/App.jsx remplacé. Garde la sauvegarde dans src/App.jsx.bak"
