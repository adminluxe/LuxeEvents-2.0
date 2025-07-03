import React from 'react'
import { Navigate } from 'react-router-dom'
import { getToken } from '../hooks/useAuth'

export default function PrivateRoute({ children }) {
  return getToken() ? children : <Navigate to="/admin/login" replace />
}
