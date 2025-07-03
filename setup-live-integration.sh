#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Démarrage du setup Live Integration…"

# 1) Installation d'axios
echo "1) Installation d'axios…"
npm install axios --save

# 2) Patch useReservation pour Strapi
echo "2) Patch src/hooks/useReservation.js…"
tee src/hooks/useReservation.js > /dev/null << 'EOF'
import { useState } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export function useReservation() {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)

  const submit = async data => {
    setLoading(true)
    setError(null)
    try {
      await axios.post(\`\${API}/api/reservations\`, { data })
    } catch (e) {
      setError(e.response?.data?.error?.message || 'Erreur serveur')
    } finally {
      setLoading(false)
    }
  }

  return { submit, loading, error }
}
EOF
echo " • useReservation.js mis à jour !"

# 3) Pop-up Newsletter → vrai endpoint
echo "3) Patch src/components/NewsletterPopup.jsx…"
sed -i '/function NewsletterPopup/ a \
  const url = import.meta.env.VITE_NEWSLETTER_URL' src/components/NewsletterPopup.jsx

sed -i '/onSubmit = async data => {/a \
      try {\
        const res = await fetch(url, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(data) });\
        if (!res.ok) throw new Error("Échec inscription");\
        toast.success("Inscription reçue !");\
        reset();\
      } catch (err) {\
        toast.error(err.message);\
      }' src/components/NewsletterPopup.jsx

echo " • NewsletterPopup.jsx mis à jour !"

echo "✅ Live Integration terminé !"
echo "→ Ajoute dans .env :"
echo "   VITE_NEWSLETTER_URL=https://your-newsletter-endpoint"
echo "   VITE_CMS_URL=https://api.ton-strapi.io"
echo "→ Relance le dev : npm run dev -- --host"
