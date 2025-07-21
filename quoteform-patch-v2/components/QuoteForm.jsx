'use client'
import React, { useState } from 'react'

const QuoteForm = () => {
  const [formData, setFormData] = useState({ name: '', email: '', type: '', message: '' })
  const [sent, setSent] = useState(false)
  const [error, setError] = useState(false)

  const handleChange = (e) => setFormData({ ...formData, [e.target.name]: e.target.value })

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSent(false)
    setError(false)

    try {
      const res = await fetch('/api/contact', {
        method: 'POST',
        body: JSON.stringify(formData),
      })

      if (res.ok) {
        setSent(true)
        setFormData({ name: '', email: '', type: '', message: '' })
      } else {
        setError(true)
      }
    } catch (err) {
      console.error('Erreur lors de l’envoi du formulaire :', err)
      setError(true)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-4 max-w-xl mx-auto">
      <input name="name" type="text" onChange={handleChange} value={formData.name} placeholder="Nom complet" required className="p-2 rounded" />
      <input name="email" type="email" onChange={handleChange} value={formData.email} placeholder="Email" required className="p-2 rounded" />
      <input name="type" type="text" onChange={handleChange} value={formData.type} placeholder="Type d'événement" className="p-2 rounded" />
      <textarea name="message" rows="5" onChange={handleChange} value={formData.message} placeholder="Détaillez votre demande" className="p-2 rounded" />
      <button type="submit" className="bg-gold text-black py-2 px-4 rounded hover:opacity-90">
        Envoyer ma demande
      </button>

      {sent && <p className="text-green-400 font-semibold">Merci ! Nous vous recontacterons sous 24h.</p>}
      {error && <p className="text-red-400 font-semibold">Une erreur est survenue. Veuillez réessayer plus tard.</p>}
    </form>
  )
}

export default QuoteForm
