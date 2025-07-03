#!/usr/bin/env bash
set -e

# Variables
API_VAR="import.meta.env.VITE_CMS_URL"
ROUTES_FILE="src/routes.jsx"
PAGES_DIR="src/pages"

echo "🌱 Scaffold des pages et routes..."

# 1) Créer Pages dir
mkdir -p $PAGES_DIR

# 2) MomentsPage.jsx (liste)
cat > $PAGES_DIR/MomentsPage.jsx << 'EOF'
import React from 'react'
import Layout from '../components/Layout'
import MomentsWall from '../components/MomentsWall'
import { useMoments } from '../hooks/useMoments'

export default function MomentsPage() {
  const { moments, loading } = useMoments()
  return (
    <Layout>
      <h1 className="text-4xl font-heading text-ivory text-stroke text-center mb-8">
        Moments d’Exception
      </h1>
      {loading
        ? <p className="text-center text-ivory">Chargement…</p>
        : <MomentsWall moments={moments} />
      }
    </Layout>
  )
}
EOF

# 3) GalleryDetail.jsx (détail)
cat > $PAGES_DIR/GalleryDetail.jsx << EOF
import React, { useEffect, useState } from 'react'
import { useParams, Navigate } from 'react-router-dom'
import axios from 'axios'
const API = $API_VAR

export default function GalleryDetail() {
  const { slug } = useParams()
  const [item, setItem] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(false)

  useEffect(() => {
    axios.get(\`\${API}/api/moments?filters[slug][$eq]=\${slug}&populate=thumbnail\`)
      .then(({ data }) => {
        const found = data.data[0]?.attributes
        if (!found) throw new Error('Not found')
        setItem(found)
      })
      .catch(() => setError(true))
      .finally(() => setLoading(false))
  }, [slug])

  if (loading) return <p>Chargement…</p>
  if (error) return <Navigate to="/moments" replace />

  return (
    <section className="space-y-6">
      <h2 className="text-3xl font-serif text-luxeGold">{item.title}</h2>
      <img
        src={item.thumbnail.data.attributes.url}
        alt={item.title}
        className="w-full max-h-96 object-cover"
      />
      <div
        className="prose prose-invert"
        dangerouslySetInnerHTML={{ __html: item.description }}
      />
    </section>
  )
}
EOF

# 4) Reserve.jsx (réservation)
cat > $PAGES_DIR/Reserve.jsx << 'EOF'
import React, { useState } from 'react'
import axios from 'axios'
const API = $API_VAR

export default function Reserve() {
  const [form, setForm] = useState({ name: '', email: '', date: '' })
  const [status, setStatus] = useState(null)

  const handleSubmit = async (e) => {
    e.preventDefault()
    try {
      await axios.post(\`\${API}/api/reservations\`, { data: form })
      setStatus('success')
    } catch {
      setStatus('error')
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4 max-w-md mx-auto">
      {['name','email','date'].map((k) => (
        <input
          key={k}
          type={k==='date'?'date':'text'}
          placeholder={k.charAt(0).toUpperCase()+k.slice(1)}
          value={form[k]}
          onChange={e => setForm({ ...form, [k]: e.target.value })}
          required
          className="w-full p-2 border rounded"
        />
      ))}
      <button type="submit" className="bg-gold px-4 py-2 rounded text-white">
        Réserver
      </button>
      {status==='success' && <p className="text-green-400">Réservation réussie ! 🎉</p>}
      {status==='error'   && <p className="text-red-400">Erreur, veuillez réessayer.</p>}
    </form>
  )
}
EOF

# 5) Générer un routes.jsx complet
cat > $ROUTES_FILE << 'EOF'
import React from 'react'
import { Routes, Route, Navigate } from 'react-router-dom'
import App from './App'
import MomentsPage from './pages/MomentsPage'
import GalleryDetail from './pages/GalleryDetail'
import Reserve from './pages/Reserve'
import TestimonialsPage from './pages/TestimonialsPage'
import ContactPage from './pages/ContactPage'

// Admin Guard example:
// const jwt = localStorage.getItem('jwt')

export default function Router() {
  return (
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/moments" element={<MomentsPage />} />
      <Route path="/moments/:slug" element={<GalleryDetail />} />
      <Route path="/reserver" element={<Reserve />} />
      <Route path="/temoignages" element={<TestimonialsPage />} />
      <Route path="/contact" element={<ContactPage />} />
      {/* Protected route example:
      <Route
        path="/admin-area"
        element={jwt ? <AdminPage /> : <Navigate to="/" replace />}
      /> */}
    </Routes>
  )
}
EOF

echo "✅ Scaffold terminé — pages et routes créées."
