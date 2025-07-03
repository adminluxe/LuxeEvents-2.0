#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Démarrage du setup Next Steps…"

# 1) Désactiver l’overlay Vite HMR
echo "1) Désactivation de l’overlay HMR dans vite.config.js…"
if ! grep -q "hmr: { overlay: false }" vite.config.js; then
  sed -i "/defineConfig({/a \ \ server: { hmr: { overlay: false } }," vite.config.js
fi

# 2) Générer la page Prestations
echo "2) Création de src/pages/Prestations.jsx…"
mkdir -p src/pages
tee src/pages/Prestations.jsx > /dev/null << 'EOF'
import React from 'react'
import Button from '../components/ui/Button'
export default function Prestations() {
  const offers = [
    {
      title: 'Mariages & Cérémonies',
      desc: 'Coordination parfaite, décor sur-mesure et moments empreints d’émotion.',
    },
    {
      title: 'Soirées Privées',
      desc: 'Ambiance raffinée, DJs & artistes de renom, scénographie immersive.',
    },
    {
      title: 'Événements d’Entreprise',
      desc: 'Séminaires, lancements de produits et galas clés-en-main. Impact garanti.',
    },
  ]
  return (
    <div className="mx-auto max-w-4xl p-6 space-y-8">
      <h1 className="text-4xl font-bold text-center">Nos Prestations</h1>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {offers.map(o => (
          <div key={o.title} className="bg-white rounded-lg shadow p-6 hover:scale-105 transition">
            <h2 className="text-2xl font-semibold mb-2">{o.title}</h2>
            <p className="text-gray-600">{o.desc}</p>
          </div>
        ))}
      </div>
      <div className="text-center mt-8">
        <Button onClick={() => window.location.href='/contact'}>Contactez-nous</Button>
      </div>
    </div>
  )
}
EOF

# 3) Générer le formulaire de contact
echo "3) Création de src/pages/Contact.jsx et hook useContact…"
mkdir -p src/hooks src/pages
tee src/hooks/useContact.js > /dev/null << 'EOF'
import { useState } from 'react'
export function useContact() {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)
  const submit = async data => {
    setLoading(true)
    setError(null)
    try {
      // Remplace par ton endpoint réel ou mailer
      await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      })
    } catch (e) {
      setError('Erreur lors de l’envoi')
    } finally {
      setLoading(false)
    }
  }
  return { submit, loading, error }
}
EOF

tee src/pages/Contact.jsx > /dev/null << 'EOF'
import React from 'react'
import { useForm } from 'react-hook-form'
import { toast } from 'react-toastify'
import { useContact } from '../hooks/useContact'
import Button from '../components/ui/Button'
import 'react-toastify/dist/ReactToastify.css'

export default function Contact() {
  const { register, handleSubmit, reset } = useForm()
  const { submit, loading, error } = useContact()
  const onSubmit = async data => {
    await submit(data)
    if (!error) {
      toast.success('Message envoyé !')
      reset()
    } else {
      toast.error(error)
    }
  }
  return (
    <div className="mx-auto max-w-md p-6 bg-white rounded-lg shadow">
      <h2 className="text-2xl font-bold mb-4 text-center">Contactez-nous</h2>
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <input {...register('name')} placeholder="Nom" className="w-full border px-3 py-2 rounded" />
        <input {...register('email')} type="email" placeholder="Email" className="w-full border px-3 py-2 rounded" />
        <textarea {...register('message')} placeholder="Votre message" className="w-full border px-3 py-2 rounded h-32" />
        <Button type="submit" disabled={loading}>{loading ? 'Envoi…' : 'Envoyer'}</Button>
      </form>
      <toast.Container />
    </div>
  )
}
EOF

# 4) Mettre à jour les routes
echo "4) Ajout des routes /prestations et /contact…"
sed -i "/<Routes>/a \ \ \ \ <Route path=\"/prestations\" element={<Prestations/>} />\n    <Route path=\"/contact\" element={<Contact/>} />" src/routes.jsx

# 5) Installer les dependances
echo "5) Installation de react-hook-form et react-toastify…"
npm install react-hook-form react-toastify

# 6) Créer la CI GitHub pour déploiement (Vercel)
echo "6) Création de .github/workflows/deploy.yml…"
mkdir -p .github/workflows
tee .github/workflows/deploy.yml > /dev/null << 'EOF'
name: Deploy to Vercel
on:
  push:
    branches: [ main ]
jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: pnpm/action-setup@v2
        with: node-version: '18'
      - run: npm install
      - run: npm run build
      - uses: amondnet/vercel-action@v20
        with:
          vercel-token: \${{ secrets.VERCEL_TOKEN }}
          vercel-args: "--prod"
          working-directory: ./
EOF

# 7) Injecter Google Analytics dans Layout
echo "7) Injection de GA dans src/components/Layout.jsx…"
if grep -q "GA_TRACKING_ID" src/components/Layout.jsx; then
  echo " → GA déjà configuré"
else
  sed -i "/<Helmet>/a \
        <script async src=\\"https://www.googletagmanager.com/gtag/js?id=GA_TRACKING_ID\\"></script>\
        <script>\
          window.dataLayer=window.dataLayer||[];\
          function gtag(){dataLayer.push(arguments);}\
          gtag('js', new Date());\
          gtag('config','GA_TRACKING_ID');\
        </script>" src/components/Layout.jsx
  echo " → Remplace GA_TRACKING_ID par ton ID réel dans Layout.jsx"
fi

echo "✅ Setup Next Steps terminé !"
echo "→ N’oublie pas de :"
echo "   • Mettre à jour ton endpoint de contact ou Strapi" 
echo "   • Ajouter VERCEL_TOKEN comme secret GitHub" 
echo "   • Remplacer GA_TRACKING_ID par ton identifiant Analytics" 
echo "→ Relance : npm run dev -- --host  et file:///.github/workflows/deploy.yml pour tester"
