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
