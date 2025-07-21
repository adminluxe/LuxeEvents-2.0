#!/usr/bin/env bash
set -e

echo "🚀 Installation des dépendances..."
pnpm install framer-motion react-lottie-player use-dark-mode rellax react-i18next i18next

echo "🧹 Création des dossiers nécessaires..."
mkdir -p src/hooks src/data src/locales src/media

echo "🎨 Écriture du design system (globals.css)..."
cat > src/globals.css << 'EOCSS'
:root {
  --color-bg-day: #faf9f6;
  --color-bg-night: #1a1a1a;
  --color-primary: #e6c17e;
  --color-text: #333;
  --color-text-invert: #f5f5f5;
  --font-size-base: clamp(0.9rem, 1.2vw + 0.1rem, 1.1rem);
  --spacing-base: 1rem;
}
[data-theme="night"] {
  --color-bg: var(--color-bg-night);
  --color-text: var(--color-text-invert);
}
[data-theme="day"] {
  --color-bg: var(--color-bg-day);
  --color-text: var(--color-text);
}
html {
  font-size: var(--font-size-base);
  background: var(--color-bg);
  color: var(--color-text);
  transition: background 0.4s, color 0.4s;
}
body {
  margin: 0;
  line-height: 1.6;
}
.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: calc(var(--spacing-base) * 1.5);
}
.testimonials {
  display: grid;
  grid-template-columns: 1fr;
}
@media (min-width: 768px) {
  .testimonials {
    grid-template-columns: repeat(2, 1fr);
  }
}
a, button {
  font-size: 1rem;
  padding: 0.75rem 1.5rem;
  border: 2px solid var(--color-primary);
  border-radius: 2rem;
  transition: transform 0.2s, box-shadow 0.2s;
}
a:hover, button:hover {
  transform: scale(1.05);
  box-shadow: 0 0 10px var(--color-primary);
}
.cursor {
  position: fixed;
  pointer-events: none;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: var(--color-primary);
  mix-blend-mode: difference;
  transform: translate(-50%, -50%);
  transition: width 0.2s, height 0.2s;
  z-index: 9999;
}
EOCSS

echo "📘 Hook React pour le thème (useTheme.js)..."
cat > src/hooks/useTheme.js << 'EOFJS'
import React from 'react';
import useDarkMode from 'use-dark-mode';
export function useTheme() {
  const darkMode = useDarkMode(false, { storageKey: 'luxeevents-theme' });
  React.useEffect(() => {
    document.documentElement.setAttribute('data-theme', darkMode.value ? 'night' : 'day');
  }, [darkMode.value]);
  return darkMode;
}
EOFJS

echo "🔌 Initialisation i18n (i18n.js + locales)..."
cat > src/i18n.js << 'EOFJS'
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import en from './locales/en.json';
import fr from './locales/fr.json';
i18n.use(initReactI18next).init({
  resources: { en: { translation: en }, fr: { translation: fr } },
  lng: 'fr',
  fallbackLng: 'en',
  interpolation: { escapeValue: false },
});
export default i18n;
EOFJS

cat > src/locales/en.json << 'EOFJSON'
{
  "welcome": "Experience luxury redefined"
}
EOFJSON

cat > src/locales/fr.json << 'EOFJSON'
{
  "welcome": "Le luxe réinventé par l'expérience"
}
EOFJSON

echo "📂 Données témoignages (testimonials.js)..."
cat > src/data/testimonials.js << 'EOFJS'
export const testimonials = [
  {
    fr: { name: 'Julie & Marc', text: 'LuxeEvents a transformé notre mariage en un conte de fées !' },
    en: { name: 'Julie & Mark', text: 'LuxeEvents turned our wedding into a modern fairy tale!' },
  },
  {
    fr: { name: 'Sophie & Paul', text: 'Professionnalisme et élégance du début à la fin.' },
    en: { name: 'Sophie & Paul', text: 'Professionalism and elegance from start to finish.' },
  },
  {
    fr: { name: 'Anna & Leo', text: 'Une équipe à l’écoute et un résultat éblouissant.' },
    en: { name: 'Anna & Leo', text: 'A team that listens and a dazzling result.' },
  }
];
EOFJS

echo "🎥 Placeholder média (ajoute ton ambiance-luxe.mp4 et logo.json)..."
touch src/media/ambiance-luxe.mp4
touch src/media/logo.json

echo "🖥️ Création du composant Cursor.jsx..."
cat > src/Cursor.jsx << 'EOFJS'
import React, { useEffect, useState } from 'react';
export default function Cursor() {
  const [pos, setPos] = useState({ x: 0, y: 0 });
  useEffect(() => {
    const move = e => setPos({ x: e.clientX, y: e.clientY });
    window.addEventListener('mousemove', move);
    return () => window.removeEventListener('mousemove', move);
  }, []);
  return <div className="cursor" style={{ left: pos.x, top: pos.y }} />;
}
EOFJS

echo "🌟 Mise à jour de main.jsx pour thème, i18n et cursor..."
cat > src/main.jsx << 'EOFJS'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.jsx';
import './globals.css';
import './i18n';
import { useTheme } from './hooks/useTheme';
import Cursor from './Cursor.jsx';

function Root() {
  const theme = useTheme();
  return (
    <>
      <button onClick={theme.toggle} aria-label="Toggle theme" style={{ position: 'fixed', top: 10, right: 10, zIndex: 10000 }}>
        {theme.value ? '☀️' : '🌙'}
      </button>
      <Cursor />
      <App />
    </>
  );
}

ReactDOM.createRoot(document.getElementById('root')).render(<Root />);
EOFJS

echo "📱 Ajout de l’exemple Hero avec vidéo (Hero.jsx)..."
cat > src/components/Hero.jsx << 'EOFJS'
import React from 'react';
export default function Hero() {
  return (
    <div className="hero-container">
      <video autoPlay muted loop className="hero-bg">
        <source src="/media/ambiance-luxe.mp4" type="video/mp4" />
      </video>
      <div className="hero-content">
        <h1>{/* i18n translation here */}</h1>
        <button>Demandez un devis</button>
      </div>
    </div>
  );
}
EOFJS

echo "🔄 Ajout du hook Parallax (useParallax.js)..."
cat > src/hooks/useParallax.js << 'EOFJS'
import { useEffect } from 'react';
import Rellax from 'rellax';
export function useParallax(selector, speed = -2) {
  useEffect(() => {
    const rellax = new Rellax(selector, { speed, center: true });
    return () => rellax.destroy();
  }, [selector, speed]);
}
EOFJS

echo "💫 Exemple de carte animée (Card.jsx)..."
cat > src/components/Card.jsx << 'EOFJS'
import { motion } from 'framer-motion';
export default function Card({ children }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6 }}
      whileHover={{ scale: 1.03, boxShadow: '0 0 15px var(--color-primary)' }}
    >
      {children}
    </motion.div>
  );
}
EOFJS

echo "✅ Tout est en place ! Relance maintenant :"
echo "pnpm run build && vercel build --prod --yes && vercel --prebuilt --prod --yes"
