#!/usr/bin/env bash
set -e

FILE=src/pages/RequestQuotePage.jsx

echo "🛠  Génération de la page RequestQuotePage avec formulaire…"

cat > "\$FILE" << 'RQF'
import React from 'react'
import { useForm } from 'react-hook-form'

export default function RequestQuotePage() {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting, isSubmitSuccessful }
  } = useForm()

  const onSubmit = async (data) => {
    // TODO: Envoyer 'data' à ton API ou service externe
    console.log('Demande envoyée :', data)
    // Simule une attente
    return new Promise((r) => setTimeout(r, 500))
  }

  return (
    <div className="pt-20 max-w-xl mx-auto">
      <h2 className="text-3xl font-bold mb-6 text-center">Demande de devis</h2>

      {isSubmitSuccessful && (
        <div className="mb-4 p-4 bg-green-100 text-green-800 rounded">
          Merci ! Votre demande a bien été prise en compte.
        </div>
      )}

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <div>
          <label className="block font-medium">Votre nom *</label>
          <input
            {...register('name', { required: 'Le nom est requis.' })}
            className="w-full mt-1 px-3 py-2 border rounded"
            placeholder="Jean Dupont"
          />
          {errors.name && (
            <p className="mt-1 text-sm text-red-600">{errors.name.message}</p>
          )}
        </div>

        <div>
          <label className="block font-medium">Email *</label>
          <input
            type="email"
            {...register('email', {
              required: 'L’email est requis.',
              pattern: {
                value: /^[^@\s]+@[^@\s]+\.[^@\s]+$/,
                message: 'Email invalide.'
              }
            })}
            className="w-full mt-1 px-3 py-2 border rounded"
            placeholder="mail@exemple.com"
          />
          {errors.email && (
            <p className="mt-1 text-sm text-red-600">{errors.email.message}</p>
          )}
        </div>

        <div>
          <label className="block font-medium">Date de l’événement *</label>
          <input
            type="date"
            {...register('date', { required: 'La date est requise.' })}
            className="w-full mt-1 px-3 py-2 border rounded"
          />
          {errors.date && (
            <p className="mt-1 text-sm text-red-600">{errors.date.message}</p>
          )}
        </div>

        <div>
          <label className="block font-medium">Type d’événement</label>
          <select
            {...register('type')}
            className="w-full mt-1 px-3 py-2 border rounded"
          >
            <option value="">— choisissez —</option>
            <option value="mariage">Mariage</option>
            <option value="anniversaire">Anniversaire</option>
            <option value="corporate">Événement corporate</option>
            <option value="autre">Autre</option>
          </select>
        </div>

        <div>
          <label className="block font-medium">Nombre approximatif d’invités</label>
          <input
            type="number"
            {...register('guests', {
              min: { value: 1, message: 'Doit être ≥ 1' }
            })}
            className="w-full mt-1 px-3 py-2 border rounded"
            placeholder="Ex : 50"
          />
          {errors.guests && (
            <p className="mt-1 text-sm text-red-600">{errors.guests.message}</p>
          )}
        </div>

        <div>
          <label className="block font-medium">Message / détails</label>
          <textarea
            {...register('message')}
            className="w-full mt-1 px-3 py-2 border rounded"
            rows="4"
            placeholder="Tell us more…"
          />
        </div>

        <button
          type="submit"
          disabled={isSubmitting}
          className="w-full py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold rounded"
        >
          {isSubmitting ? 'Envoi…' : 'Envoyer la demande'}
        </button>
      </form>
    </div>
  )
}
RQF

echo "✅ $FILE généré."
echo "💡 Relance le serveur dev pour voir le résultat : pnpm run dev"
