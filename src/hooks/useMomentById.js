import { useState, useEffect } from 'react'
import axios from 'axios'
import { authHeader } from '../hooks/useAuth'
const API = import.meta.env.VITE_CMS_URL

export function useMomentById(id) {
  const [item, setItem] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    if (!id) return
    axios.get(\`\${API}/api/moments/\${id}?populate=thumbnail,content,gallery\`, { headers: authHeader() })
      .then(res => setItem(res.data.data.attributes))
      .catch(err => setError(err))
      .finally(() => setLoading(false))
  }, [id])

  return { item, loading, error }
}
