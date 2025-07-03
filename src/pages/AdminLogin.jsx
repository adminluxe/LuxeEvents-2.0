import React from 'react'
import { useForm } from 'react-hook-form'
import { loginAdmin } from '../hooks/useAuth'
import { useNavigate } from 'react-router-dom'
import { toast } from 'react-toastify'

export default function AdminLogin() {
  const { register, handleSubmit } = useForm()
  const navigate = useNavigate()

  const onSubmit = async ({ identifier, password }) => {
    try {
      await loginAdmin(identifier, password)
      toast.success('Login réussi 🎉')
      navigate('/admin')
    } catch {
      toast.error('Identifiants invalides')
    }
  }

  return (
    <div className="mx-auto max-w-sm p-6 bg-white rounded shadow">
      <h2 className="text-2xl font-bold mb-4">Admin Login</h2>
      <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <input {...register('identifier')} placeholder="Email" className="w-full border px-3 py-2 rounded" />
        <input {...register('password')} type="password" placeholder="Mot de passe" className="w-full border px-3 py-2 rounded" />
        <button type="submit" className="w-full bg-gold py-2 rounded hover:scale-105 transition-transform">Se connecter</button>
      </form>
    </div>
  )
}
