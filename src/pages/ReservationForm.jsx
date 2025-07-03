import React from 'react'
import { useForm } from 'react-hook-form'
import DatePicker from "react-datepicker"
import "react-datepicker/dist/react-datepicker.css"
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
  const [startDate, setStartDate] = React.useState(new Date())

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
      <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit(onSubmit)} className="space-y-4">
  role="form" aria-describedby="reservation-desc"
  role="form" aria-describedby="reservation-desc"
  role="form" aria-describedby="reservation-desc"
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
