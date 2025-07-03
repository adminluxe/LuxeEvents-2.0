#!/usr/bin/env bash
set -euo pipefail

echo "🔒 Démarrage du scaffold Espace Admin…"

# 1) Hook useAuth et PrivateRoute
echo "1) Création de src/hooks/useAuth.js et PrivateRoute…"
mkdir -p src/hooks src/components
tee src/hooks/useAuth.js > /dev/null << 'EOF'
import { useState, useEffect } from 'react'
import axios from 'axios'

const API = import.meta.env.VITE_CMS_URL
const TOKEN_KEY = 'jwt'

export function loginAdmin(identifier, password) {
  return axios.post(\`\${API}/api/auth/local\`, { identifier, password })
    .then(res => {
      localStorage.setItem(TOKEN_KEY, res.data.jwt)
      return res.data.user
    })
}

export function logoutAdmin() {
  localStorage.removeItem(TOKEN_KEY)
}

export function getToken() {
  return localStorage.getItem(TOKEN_KEY)
}

export function authHeader() {
  const token = getToken()
  return token ? { Authorization: \`Bearer \${token}\` } : {}
}
EOF

tee src/components/PrivateRoute.jsx > /dev/null << 'EOF'
import React from 'react'
import { Navigate } from 'react-router-dom'
import { getToken } from '../hooks/useAuth'

export default function PrivateRoute({ children }) {
  return getToken() ? children : <Navigate to="/admin/login" replace />
}
EOF

# 2) Page Login Admin
echo "2) Création de src/pages/AdminLogin.jsx…"
mkdir -p src/pages
tee src/pages/AdminLogin.jsx > /dev/null << 'EOF'
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
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <input {...register('identifier')} placeholder="Email" className="w-full border px-3 py-2 rounded" />
        <input {...register('password')} type="password" placeholder="Mot de passe" className="w-full border px-3 py-2 rounded" />
        <button type="submit" className="w-full bg-gold py-2 rounded hover:scale-105 transition-transform">Se connecter</button>
      </form>
    </div>
  )
}
EOF

# 3) Page Dashboard Admin CRUD Moments
echo "3) Création de src/pages/AdminDashboard.jsx…"
tee src/pages/AdminDashboard.jsx > /dev/null << 'EOF'
import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { authHeader, logoutAdmin } from '../hooks/useAuth'
import { useNavigate } from 'react-router-dom'
import { toast } from 'react-toastify'

const API = import.meta.env.VITE_CMS_URL

export default function AdminDashboard() {
  const [moments, setMoments] = useState([])
  const navigate = useNavigate()

  useEffect(() => {
    axios.get(\`\${API}/api/moments?populate=thumbnail\`, { headers: authHeader() })
      .then(res => setMoments(res.data.data))
      .catch(() => toast.error('Erreur de chargement'))
  }, [])

  const handleDelete = (id) => {
    axios.delete(\`\${API}/api/moments/\${id}\`, { headers: authHeader() })
      .then(() => {
        setMoments(m => m.filter(x => x.id !== id))
        toast.success('Supprimé')
      })
      .catch(() => toast.error('Erreur suppression'))
  }

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold">Admin Dashboard</h1>
        <button onClick={() => { logoutAdmin(); navigate('/admin/login') }} className="bg-red-500 text-white px-4 py-2 rounded">Logout</button>
      </div>
      <button onClick={() => navigate('/admin/create')} className="mb-4 bg-green-500 text-white px-4 py-2 rounded">Créer un Moment</button>
      <ul className="space-y-4">
        {moments.map(m => (
          <li key={m.id} className="flex justify-between items-center bg-white p-4 rounded shadow">
            <span>{m.attributes.title}</span>
            <div className="space-x-2">
              <button onClick={() => navigate(\`/admin/edit/\${m.id}\`)} className="px-3 py-1 border rounded">✏️ Edit</button>
              <button onClick={() => handleDelete(m.id)} className="px-3 py-1 border rounded text-red-600">🗑️ Delete</button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  )
}
EOF

# 4) Mise à jour des routes admin
echo "4) Ajout des routes Admin dans src/routes.jsx…"
sed -i "/<Routes>/a \ \ \ \ <Route path=\"/admin/login\" element={<AdminLogin/>} />\n    <Route path=\"/admin/*\" element={<PrivateRoute><AdminDashboard/></PrivateRoute>} />" src/routes.jsx

# 5) Installation des dépendances toast
echo "5) Installation de react-toastify…"
npm install react-toastify

echo "✅ Espace Admin prêt !"
echo "→ À toi de créer les pages Create/Edit et peaufiner l’UI."
