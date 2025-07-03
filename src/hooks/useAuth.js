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
