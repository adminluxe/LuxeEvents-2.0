import React, { useState } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export default function Reserve() {
  const [form, setForm] = useState({ name: '', email: '', date: '' })
  const [status, setStatus] = useState(null)

  const handleSubmit = async (e) => {
    e.preventDefault()
    try {
      await axios.post(API + '/api/reservations', { data: form })
      setStatus('success')
    } catch {
      setStatus('error')
    }
  }

  return (
    <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit} className="space-y-4 px-4 max-w-md mx-auto">
      {['name','email','date'].map((k) => (
        <input
          key={k}
          type={k === 'date' ? 'date' : 'text'}
          placeholder={k.charAt(0).toUpperCase() + k.slice(1)}
          value={form[k]}
          onChange={e => setForm({ ...form, [k]: e.target.value })}
          required
          className="w-full p-2 border rounded"
        />
      ))}
      <button type="submit" className="bg-gold px-4 py-2 rounded">Réserver</button>
      {status === 'success' && <p className="text-green-400">Réservation réussie ! 🎉</p>}
      {status === 'error'   && <p className="text-red-400">Erreur, veuillez réessayer.</p>}
    </form>
  )
}
