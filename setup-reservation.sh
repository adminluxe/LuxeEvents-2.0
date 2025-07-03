#!/usr/bin/env bash
set -euo pipefail

echo "⚙️  Démarrage du scaffold Formulaire de Réservation…"

# 1) Hook useReservation pour l’envoi
echo "1) Génération de src/hooks/useReservation.js…"
mkdir -p src/hooks
tee src/hooks/useReservation.js > /dev/null << 'EOF'
import { useState } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export function useReservation() {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)

  const submit = async (data) => {
    setLoading(true)
    setError(null)
    try {
      await axios.post(\`\${API}/api/reservations\`, { data })
    } catch (err) {
      setError(err.response?.data?.error?.message || 'Erreur inconnue')
    } finally {
      setLoading(false)
    }
  }

  return { submit, loading, error }
}
EOF

# 2) Composant ReservationForm.jsx
echo "2) Création de src/pages/ReservationForm.jsx…"
mkdir -p src/pages
tee src/pages/ReservationForm.jsx > /dev/null << 'EOF'
import React from 'react'
import { useForm } from 'react-hook-form'
import { yupResolver } from '@hookform/resolvers/yup'
import * as yup from 'yup'
import { useReservation } from '../hooks/useReservation'
import { toast } from 'react-toastify'

const schema = yup.object().shape({
  name: yup.string().required('Nom requis'),
  email: yup.string().email('Email invalide').required('Email requis'),
  phone: yup.string().required('Téléphone requis'),
  date: yup.date().required('Date requise'),
  guests: yup.number().min(1, 'Au moins 1 personne').required('Nombre requis'),
})

export default function ReservationForm() {
  const { submit, loading, error } = useReservation()
  const { register, handleSubmit, formState: { errors } } = useForm({
    resolver: yupResolver(schema)
  })

  const onSubmit = async (data) => {
    await submit(data)
    if (!error) {
      toast.success('Réservation validée 🎉')
    }
  }

  return (
    <div className="mx-auto max-w-md p-6 bg-white rounded-lg shadow">
      <h2 className="text-2xl font-bold mb-4">Réserver l’Exception</h2>
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        {[
          { label: 'Nom', name: 'name', type: 'text' },
          { label: 'Email', name: 'email', type: 'email' },
          { label: 'Téléphone', name: 'phone', type: 'tel' },
          { label: 'Date', name: 'date', type: 'date' },
          { label: 'Nombre de personnes', name: 'guests', type: 'number' },
        ].map(({ label, name, type }) => (
          <div key={name}>
            <label className="block mb-1">{label}</label>
            <input
              type={type}
              {...register(name)}
              className="w-full border px-3 py-2 rounded"
            />
            {errors[name] && <p className="text-red-600 text-sm">{errors[name].message}</p>}
          </div>
        ))}
        <button type="submit" disabled={loading}
          className="w-full bg-gold text-black py-2 rounded hover:scale-105 transition-transform">
          {loading ? 'Envoi…' : 'Réservez maintenant'}
        </button>
        {error && <p className="text-red-600 text-center mt-2">{error}</p>}
      </form>
    </div>
  )
}
EOF

# 3) Ajout de la route /reserver
echo "3) Mise à jour de src/routes.jsx…"
sed -i "/<Routes>/a \ \ \ \ <Route path=\"/reserver\" element={<ReservationForm/>} />" src/routes.jsx

# 4) Installation des dépendances
echo "4) Installation de react-hook-form, yup, resolvers et react-toastify…"
npm install react-hook-form yup @hookform/resolvers react-toastify

echo "✅ Scaffold Réservation prêt !"
echo "→ Personnalise les styles Tailwind/animations et amuse-toi bien !"
