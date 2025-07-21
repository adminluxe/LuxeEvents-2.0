#!/usr/bin/env bash
set -e

PAGE="src/pages/RequestQuotePage.jsx"
DIR="src/pages"
echo "🚀 1. Création du composant RequestQuotePage avec formulaire…"

# Créer le dossier pages si besoin
mkdir -p $DIR

# Installer react-hook-form si absent
if ! grep -q "react-hook-form" package.json; then
  echo "📦 Installation de react-hook-form…"
  pnpm add react-hook-form
else
  echo "ℹ react-hook-form déjà installé, skip."
fi

# Générer le composant
cat > $PAGE << 'RQ'
import React from 'react'
import { useForm } from 'react-hook-form'

export default function RequestQuotePage() {
  const { register, handleSubmit, formState: { errors, isSubmitSuccessful } } = useForm()
  const onSubmit = data => {
    console.log('Formulaire soumis :', data)
    // TODO : envoyer vers votre API / service
  }

  return (
    <div className="pt-20 max-w-xl mx-auto px-4">
      <h2 className="text-3xl font-bold mb-6 text-center">Demande de devis</h2>

      {isSubmitSuccessful && (
        <p className="mb-4 p-3 bg-green-100 text-green-800 rounded">
          Merci ! Votre demande a bien été prise en compte.
        </p>
      )}

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <div>
          <label className="block mb-1 font-medium" htmlFor="name">Nom / Société*</label>
          <input
            id="name"
            {...register('name', { required: 'Ce champ est requis' })}
            className="w-full border rounded px-3 py-2"
          />
          {errors.name && (
            <p className="mt-1 text-sm text-red-600">{errors.name.message}</p>
          )}
        </div>

        <div>
          <label className="block mb-1 font-medium" htmlFor="email">Email*</label>
          <input
            id="email"
            type="email"
            {...register('email', {
              required: 'Ce champ est requis',
              pattern: { value: /^\S+@\S+$/i, message: 'Email invalide' }
            })}
            className="w-full border rounded px-3 py-2"
          />
          {errors.email && (
            <p className="mt-1 text-sm text-red-600">{errors.email.message}</p>
          )}
        </div>

        <div>
          <label className="block mb-1 font-medium" htmlFor="phone">Téléphone</label>
          <input
            id="phone"
            {...register('phone')}
            className="w-full border rounded px-3 py-2"
          />
        </div>

        <div>
          <label className="block mb-1 font-medium" htmlFor="message">Message*</label>
          <textarea
            id="message"
            rows="5"
            {...register('message', { required: 'Ce champ est requis' })}
            className="w-full border rounded px-3 py-2"
          />
          {errors.message && (
            <p className="mt-1 text-sm text-red-600">{errors.message.message}</p>
          )}
        </div>

        <button
          type="submit"
          className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 rounded"
        >
          Envoyer ma demande
        </button>
      </form>
    </div>
  )
}
RQ

chmod +x scaffold-request-form.sh
echo "🎉 Composant créé : $PAGE"
echo "👉 Lancez maintenant : ./scaffold-request-form.sh"
