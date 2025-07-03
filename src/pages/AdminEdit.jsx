import React from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useForm } from 'react-hook-form'
import { yupResolver } from '@hookform/resolvers/yup'
import * as yup from 'yup'
import axios from 'axios'
import { authHeader } from '../hooks/useAuth'
import { toast } from 'react-toastify'
import { useMomentById } from '../hooks/useMomentById'
import Button from '../components/ui/Button'
import Input from '../components/ui/Input'

const schema = yup.object().shape({
  title: yup.string().required(),
  description: yup.string().required(),
  date: yup.date().required(),
  theme: yup.string().required(),
  price: yup.number().required(),
})

export default function AdminEdit() {
  const { id } = useParams()
  const navigate = useNavigate()
  const { item, loading } = useMomentById(id)
  const { register, handleSubmit, reset, formState: { errors } } = useForm({ resolver: yupResolver(schema) })

  React.useEffect(() => {
    if (item) reset(item)
  }, [item, reset])

  const onSubmit = async data => {
    try {
      await axios.put(\`\${import.meta.env.VITE_CMS_URL}/api/moments/\${id}\`, { data }, { headers: authHeader() })
      toast.success('Moment mis à jour 🎉')
      navigate('/admin')
    } catch {
      toast.error('Erreur mise à jour')
    }
  }

  if (loading) return <p>Chargement…</p>
  return (
    <div className="p-6 max-w-lg mx-auto">
      <h2 className="text-2xl font-bold mb-4">Modifier un Moment</h2>
      <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <Input label="Titre" {...register('title')} error={errors.title?.message} />
        <Input label="Description" {...register('description')} error={errors.description?.message} />
        <Input label="Date" type="date" {...register('date')} error={errors.date?.message} />
        <Input label="Thème" {...register('theme')} error={errors.theme?.message} />
        <Input label="Prix (€)" type="number" {...register('price')} error={errors.price?.message} />
        <Button type="submit">Enregistrer</Button>
      </form>
    </div>
  )
}
