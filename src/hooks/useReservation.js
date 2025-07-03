import { useState } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export function useReservation() {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)

  const submit = async data => {
    setLoading(true)
    setError(null)
    try {
      await axios.post(\`\${API}/api/reservations\`, { data })
    } catch (e) {
      setError(e.response?.data?.error?.message || 'Erreur serveur')
    } finally {
      setLoading(false)
    }
  }

  return { submit, loading, error }
}
