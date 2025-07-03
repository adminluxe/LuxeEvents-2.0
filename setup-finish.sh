#!/usr/bin/env bash
set -euo pipefail

echo "🎨 Début du setup final LuxeEvents…"

# 1) Design System Tailwind
echo "1) Mise à jour de tailwind.config.js avec les couleurs luxeGold & luxeBlack…"
sed -i "/theme: {/a \    extend: { colors: { luxeGold: '#D4AF37', luxeBlack: '#0B0B0B' } }," tailwind.config.js

# 2) UI Components réutilisables
echo "2) Création de src/components/ui/Button.jsx, Input.jsx, Card.jsx…"
mkdir -p src/components/ui
tee src/components/ui/Button.jsx > /dev/null << 'EOF'
import React from 'react'

export default function Button({ children, className = '', ...props }) {
  return (
    <button
      className={`bg-luxeGold text-luxeBlack font-semibold px-4 py-2 rounded-2xl shadow hover:scale-105 transition-transform ${className}`}
      {...props}
    >
      {children}
    </button>
  )
}
EOF

tee src/components/ui/Input.jsx > /dev/null << 'EOF'
import React from 'react'

export default function Input({ label, error, className = '', ...props }) {
  return (
    <div className={className}>
      {label && <label className="block mb-1 font-medium">{label}</label>}
      <input {...props} className="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-luxeGold" />
      {error && <p className="text-red-600 text-sm mt-1">{error}</p>}
    </div>
  )
}
EOF

tee src/components/ui/Card.jsx > /dev/null << 'EOF'
import React from 'react'
import { motion } from 'framer-motion'

export default function Card({ children, className = '' }) {
  return (
    <motion.div
      className={`bg-white rounded-lg shadow p-6 ${className}`}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4 }}
    >
      {children}
    </motion.div>
  )
}
EOF

# 3) Hook useMomentById
echo "3) Génération de src/hooks/useMomentById.js…"
mkdir -p src/hooks
tee src/hooks/useMomentById.js > /dev/null << 'EOF'
import { useState, useEffect } from 'react'
import axios from 'axios'
import { authHeader } from '../hooks/useAuth'
const API = import.meta.env.VITE_CMS_URL

export function useMomentById(id) {
  const [item, setItem] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    if (!id) return
    axios.get(\`\${API}/api/moments/\${id}?populate=thumbnail,content,gallery\`, { headers: authHeader() })
      .then(res => setItem(res.data.data.attributes))
      .catch(err => setError(err))
      .finally(() => setLoading(false))
  }, [id])

  return { item, loading, error }
}
EOF

# 4) Pages Create & Edit
echo "4) Création de src/pages/AdminCreate.jsx & AdminEdit.jsx…"
mkdir -p src/pages
tee src/pages/AdminCreate.jsx > /dev/null << 'EOF'
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
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
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
EOF

tee src/pages/AdminEdit.jsx > /dev/null << 'EOF'
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
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
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
EOF

# 5) Routes Create/Edit
echo "5) Ajout des routes /admin/create et /admin/edit/:id dans src/routes.jsx…"
sed -i "/<Route path=\"\/admin\"/a \ \ \ \ <Route path=\"create\" element={<AdminCreate/>} />\n    <Route path=\"edit/:id\" element={<AdminEdit/>} />" src/routes.jsx

# 6) Installation des dépendances
echo "6) Installation des libs Form & Animations…"
npm install react-hook-form yup @hookform/resolvers react-toastify framer-motion

echo "✅ Setup final terminé ! 🎉"
echo "→ Tes pages Admin Create/Edit, tes composants UI et ton design system sont en place."
