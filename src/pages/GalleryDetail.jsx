import React, { useEffect, useState } from 'react'
import { useParams, Navigate } from 'react-router-dom'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export default function GalleryDetail() {
  const { slug } = useParams()
  const [item, setItem] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(false)

  useEffect(() => {
    axios.get(`${API}/api/moments?filters[slug][]=${slug}&populate=thumbnail`)
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
