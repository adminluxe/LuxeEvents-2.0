import React from 'react'
import { useForm } from 'react-hook-form'
import { yupResolver } from '@hookform/resolvers/yup'
import * as yup from 'yup'
import axios from 'axios'
import { authHeader } from '../hooks/useAuth'
import { useNavigate } from 'react-router-dom'
import { toast } from 'react-toastify'
import Button from '../components/ui/Button'
import Input from '../components/ui/Input'

const schema = yup.object().shape({
  title: yup.string().required(),
  description: yup.string().required(),
  date: yup.date().required(),
  theme: yup.string().required(),
  price: yup.number().required(),
})

export default function AdminCreate() {
  const navigate = useNavigate()
  const { register, handleSubmit, formState: { errors } } = useForm({ resolver: yupResolver(schema) })

  const onSubmit = async data => {
    try {
      await axios.post(\`\${import.meta.env.VITE_CMS_URL}/api/moments\`, { data }, { headers: authHeader() })
      toast.success('Moment créé 🎉')
      navigate('/admin')
    } catch {
      toast.error('Erreur création')
    }
  }

  return (
    <div className="p-6 max-w-lg mx-auto">
      <h2 className="text-2xl font-bold mb-4">Créer un Moment</h2>
      <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <Input label="Titre" {...register('title')} error={errors.title?.message} />
        <Input label="Description" {...register('description')} error={errors.description?.message} />
        <Input label="Date" type="date" {...register('date')} error={errors.date?.message} />
        <Input label="Thème" {...register('theme')} error={errors.theme?.message} />
        <Input label="Prix (€)" type="number" {...register('price')} error={errors.price?.message} />
        <Button type="submit">Créer</Button>
      </form>
    </div>
  )
}
