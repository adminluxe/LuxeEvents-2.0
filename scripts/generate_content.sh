#!/usr/bin/env bash
set -euo pipefail

echo "🖋️  Génération de contenu pour les pages…"

# 1) Trads FR/EN
mkdir -p public/locales/fr public/locales/en
cat > public/locales/fr/fr.json <<'FR'
{
  "home": {
    "title": "Bienvenue chez LuxeEvents",
    "intro": "Orchestrez des événements inoubliables, alliant élégance et simplicité.",
    "services": [
      "Organisation complète de mariages & réceptions",
      "Conception de décors sur-mesure",
      "Coordination & logistique clés en main"
    ]
  },
  "about": {
    "title": "À propos de LuxeEvents",
    "intro": "Depuis 2010, nous sublimons vos moments d’exception avec passion et raffinement.",
    "history": "Née d’une passion pour l’art de recevoir, notre agence s’appuie sur un réseau d’experts triés sur le volet pour transformer vos rêves en réalité."
  },
  "gallery": {
    "title": "Galerie",
    "intro": "Quelques-unes de nos réalisations pour vous inspirer.",
    "images": []
  },
  "quote": {
    "title": "Ils nous ont fait confiance",
    "reviews": [
      { "author": "Alice & Thomas", "text": "Un mariage de rêve, sans aucun stress !" },
      { "author": "Marie D.", "text": "Service impeccable et décor somptueux." },
      { "author": "Julien L.", "text": "Des pros à l’écoute et d’excellentes idées." }
    ]
  }
}
FR

cat > public/locales/en/en.json <<'EN'
{
  "home": {
    "title": "Welcome to LuxeEvents",
    "intro": "Crafting unforgettable events with elegance and ease.",
    "services": [
      "Full wedding & reception planning",
      "Custom event design",
      "Turnkey coordination & logistics"
    ]
  },
  "about": {
    "title": "About LuxeEvents",
    "intro": "Since 2010, we've been creating exceptional moments with passion and style.",
    "history": "Born from a love of hospitality, our agency leverages a curated network of experts to bring your dreams to life."
  },
  "gallery": {
    "title": "Gallery",
    "intro": "A showcase of our finest creations.",
    "images": []
  },
  "quote": {
    "title": "What our clients say",
    "reviews": [
      { "author": "Alice & Thomas", "text": "A dream wedding without any stress!" },
      { "author": "Marie D.", "text": "Impeccable service and stunning decor." },
      { "author": "Julien L.", "text": "Professionals who really listen and have great ideas." }
    ]
  }
}
EN

echo "→ Traductions générées dans public/locales/{fr,en}"

# 2) Pages

# Home.jsx
cat > src/pages/Home.jsx <<'HOME'
import React from 'react'
import { useTranslation } from 'react-i18next'
import Layout from '@/components/Layout'

export default function Home() {
  const { t } = useTranslation()
  return (
    <Layout title={t('home.title')}>
      <section className="px-6 py-12">
        <h1 className="text-4xl font-bold mb-4">{t('home.title')}</h1>
        <p className="mb-6">{t('home.intro')}</p>
        <ul className="list-disc pl-6 space-y-2">
          {t('home.services', { returnObjects: true }).map((s, i) => (
            <li key={i}>{s}</li>
          ))}
        </ul>
      </section>
    </Layout>
  )
}
HOME

# About.jsx
cat > src/pages/About.jsx <<'ABOUT'
import React from 'react'
import { useTranslation } from 'react-i18next'
import Layout from '@/components/Layout'

export default function About() {
  const { t } = useTranslation()
  return (
    <Layout title={t('about.title')}>
      <section className="px-6 py-12 bg-luxe-light">
        <h1 className="text-4xl font-bold mb-4">{t('about.title')}</h1>
        <p className="mb-4">{t('about.intro')}</p>
        <p>{t('about.history')}</p>
      </section>
    </Layout>
  )
}
ABOUT

# Gallery.jsx
cat > src/pages/Gallery.jsx <<'GALLERY'
import React from 'react'
import { useTranslation } from 'react-i18next'
import Layout from '@/components/Layout'
import Carousel from '@/components/Carousel'

export default function Gallery() {
  const { t } = useTranslation()
  return (
    <Layout title={t('gallery.title')}>
      <section className="px-6 py-12">
        <h1 className="text-4xl font-bold mb-4">{t('gallery.title')}</h1>
        <p className="mb-6">{t('gallery.intro')}</p>
        <Carousel />
      </section>
    </Layout>
  )
}
GALLERY

# Quote.jsx
cat > src/pages/Quote.jsx <<'QUOTE'
import React from 'react'
import { useTranslation } from 'react-i18next'
import Layout from '@/components/Layout'
import Testimonials from '@/components/Testimonials'

export default function Quote() {
  const { t } = useTranslation()
  return (
    <Layout title={t('quote.title')}>
      <section className="px-6 py-12">
        <h1 className="text-4xl font-bold mb-6">{t('quote.title')}</h1>
        <Testimonials />
      </section>
    </Layout>
  )
}
QUOTE

echo "→ Pages Home, About, Gallery & Quote mises à jour"

echo "✅ Contenu raffiné généré avec succès !"
