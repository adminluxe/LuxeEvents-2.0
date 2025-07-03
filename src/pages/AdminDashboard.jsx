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
