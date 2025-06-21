#!/bin/bash

### 🚀 luxeEvents.me Frontend Scaffold Generator (Stable Version)
# Script corrigé pour éviter l'erreur "npm error could not determine executable to run"
# Crée la structure React + Vite + Tailwind + Framer Motion
e# avec composants de base directement dans le dossier courant.

set -e

# Répertoire frontal (doit être exécuté dans ~/luxeevents-frontend)
BASE_DIR="$(pwd)"

echo "ℹ️  Running scaffold in $BASE_DIR"

# 1. Initialisation du projet Vite + React si nécessaire
if [ ! -f "$BASE_DIR/package.json" ]; then
  echo "📦 Initialisation du projet Vite + React dans $BASE_DIR"
  npx create-vite@latest . -- --template react
  npm install
else
  echo "ℹ️  package.json existant, skip init Vite"
fi

# 2. Installation de Tailwind CSS et Framer Motion
echo "✨ Installation de Tailwind CSS, autoprefixer, postcss"
npm install -D tailwindcss postcss autoprefixer

echo "✨ Initialisation de Tailwind CSS"
npx tailwindcss init -p

echo "✨ Installation de Framer Motion et dépendances" 
npm install framer-motion react-router-dom react-i18next i18next

# 3. Configuration de Tailwind
echo "🔧 Configuration de tailwind.config.js"
cat > tailwind.config.js <<EOF
module.exports = {
  content: ["./index.html", "./src/**/*.{js,jsx,ts,tsx}"],
  theme: { extend: {} },
  plugins: [],
}
EOF

# 4. Structure des dossiers
echo "🗂️ Création des dossiers src/components, src/pages, src/styles"
mkdir -p src/components src/pages src/styles

# 5. Création des composants et pages
echo "🖋️ Génération des fichiers templates"
# Hero component
cat > src/components/Hero.jsx <<EOF
import React from 'react';
import { motion } from 'framer-motion';
export default function Hero() {
  return (
    <motion.section initial={{ opacity: 0 }} animate={{ opacity: 1 }}>
      <h1 className="text-5xl font-bold">Bienvenue chez luxeEvents</h1>
      <p className="mt-4 text-xl">Réinventez votre expérience événementielle</p>
      <button className="mt-6 px-6 py-3 bg-black text-white rounded">Découvrir</button>
    </motion.section>
  );
}
EOF

# ServicesGrid component
cat > src/components/ServicesGrid.jsx <<EOF
import React from 'react';
export default function ServicesGrid() {
  const services = ["Conception d'événements", "Coordination", "Décoration", "Catering"];
  return (
    <section className="mt-16 grid grid-cols-1 md:grid-cols-2 gap-8">
      {services.map((s) => (
        <div key={s} className="p-6 border rounded-lg hover:shadow-lg">
          <h3 className="text-2xl font-semibold">{s}</h3>
          <p className="mt-2 text-gray-600">Description courte pour {s}.</p>
        </div>
      ))}
    </section>
  );
}
EOF

# Events page
cat > src/pages/Events.jsx <<EOF
import React, { useState, useEffect } from 'react';
export default function Events() {
  const [events, setEvents] = useState([]);
  useEffect(() => {
    fetch(import.meta.env.VITE_BACKEND_URL + '/events')
      .then((res) => res.json())
      .then(setEvents);
  }, []);
  return (
    <section className="mt-16">
      <h2 className="text-3xl font-bold">Événements à venir</h2>
      <ul className="mt-6 space-y-4">
        {events.map((e) => (
          <li key={e.id} className="p-4 border rounded-lg">
            <h3 className="text-2xl">{e.title}</h3>
            <p className="text-gray-600">{new Date(e.date).toLocaleDateString()}</p>
          </li>
        ))}
      </ul>
    </section>
  );
}
EOF

# Contact page
cat > src/pages/Contact.jsx <<EOF
import React from 'react';
export default function Contact() {
  return (
    <section className="mt-16">
      <h2 className="text-3xl font-bold">Contactez-nous</h2>
      <form className="mt-6 space-y-4">
        <input type="text" placeholder="Votre nom" className="w-full p-3 border rounded" />
        <input type="email" placeholder="Votre email" className="w-full p-3 border rounded" />
        <textarea placeholder="Votre message" className="w-full p-3 border rounded" />
        <button type="submit" className="px-6 py-3 bg-black text-white rounded">Envoyer</button>
      </form>
    </section>
  );
}
EOF

# App.jsx
cat > src/App.jsx <<EOF
import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Hero from './components/Hero';
import ServicesGrid from './components/ServicesGrid';
import Events from './pages/Events';
import Contact from './pages/Contact';
export default function App() {
  return (
    <Router>
      <nav className="p-6 flex space-x-4">
        <Link to="/" className="font-bold">Home</Link>
        <Link to="/events">Événements</Link>
        <Link to="/contact">Contact</Link>
      </nav>
      <main className="px-6">
        <Routes>
          <Route path="/" element={<><Hero /><ServicesGrid /></>} />
          <Route path="/events" element={<Events />} />
          <Route path="/contact" element={<Contact />} />
        </Routes>
      </main>
    </Router>
  );
}
EOF

# Main entry and CSS
cat > src/main.jsx <<EOF
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

cat > src/index.css <<EOF
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

echo "✅ Scaffold stable terminé dans $BASE_DIR. Lance 'npm run dev'"
