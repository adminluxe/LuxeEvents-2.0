import { useState } from 'react'
export function useContact() {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)
  const submit = async data => {
    setLoading(true)
    setError(null)
    try {
      // Remplace par ton endpoint réel ou mailer
      await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      })
    } catch (e) {
      setError('Erreur lors de l’envoi')
    } finally {
      setLoading(false)
    }
  }
  return { submit, loading, error }
}
