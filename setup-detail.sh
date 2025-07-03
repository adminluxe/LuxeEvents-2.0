#!/usr/bin/env bash
set -euo pipefail

echo "🛠️  Démarrage du scaffold Page Détail…"

# 1) Création du hook useMoment
echo "1) Génération de src/hooks/useMoment.js…"
mkdir -p src/hooks
tee src/hooks/useMoment.js > /dev/null << 'EOF'
import { useState, useEffect } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export function useMoment(slug) {
  const [item, setItem] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    axios.get(`${API}/api/moments?filters[slug][$eq]=${slug}&populate=thumbnail,content,gallery`)
      .then(({ data }) => {
        setItem(data.data[0]?.attributes || null)
        setLoading(false)
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [slug])

  return { item, loading, error }
}
EOF

# 2) Création du composant GalleryDetail.jsx
echo "2) Création de src/components/landing/GalleryDetail.jsx…"
mkdir -p src/components/landing
tee src/components/landing/GalleryDetail.jsx > /dev/null << 'EOF'
import React from 'react'
import { useParams } from 'react-router-dom'
import { useMoment } from '../../hooks/useMoment'
import Slider from 'react-slick'

export default function GalleryDetail() {
  const { slug } = useParams()
  const { item, loading, error } = useMoment(slug)

  if (loading) return <p>Chargement…</p>
  if (error || !item) return <p>Oups, moment introuvable.</p>

  const { title, description, date, theme, price, gallery } = item

  const settings = {
    dots: true,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
  }

  return (
    <div className="mx-auto max-w-4xl p-4">
      <h1 className="text-4xl font-bold mb-4">{title}</h1>
      <p className="text-gray-600 mb-6" dangerouslySetInnerHTML={{ __html: description }} />
      <div className="mb-6">
        <span className="mr-4">📅 {new Date(date).toLocaleDateString()}</span>
        <span className="mr-4">🎨 {theme}</span>
        <span>💶 {price} €</span>
      </div>
      <Slider {...settings}>
        {gallery.data.map(({ id, attributes }) => (
          <div key={id}>
            <img
              src={attributes.url}
              alt={`Galerie ${id}`}
              className="w-full h-96 object-cover rounded-lg"
            />
          </div>
        ))}
      </Slider>
    </div>
  )
}
EOF

# 3) Mise à jour de ton routes.jsx
echo "3) Ajout de la route /detail/:slug dans src/routes.jsx…"
sed -i "/<Routes>/a \ \ \ \ <Route path=\"/detail/:slug\" element={<GalleryDetail/>} />" src/routes.jsx

# 4) Installation de react-slick et slick-carousel si besoin
echo "4) Vérification des dépendances react-slick…"
npm install react-slick slick-carousel --save

echo "✅ Scaffold Page Détail prêt !"
echo "Il ne te reste plus qu’à ajuster styles et animations (Tailwind/Framer Motion) pour sublimer tes images."
