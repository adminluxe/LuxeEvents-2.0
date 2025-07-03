#!/usr/bin/env bash
set -euo pipefail

echo "🍹 Démarrage du cocktail des 5 Final Touch…"

# 1) Animer les cartes Prestations
echo "1) Ajout de Framer Motion dans Prestations.jsx…"
npm install framer-motion --save
sed -i '/import Button/a import { motion } from "framer-motion"' src/pages/Prestations.jsx
sed -i -E '/offers\.map/{
  N
  s|<div key=(.+)>|<motion.div key=\1 className="bg-white rounded-lg shadow p-6 cursor-pointer" initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} whileHover={{ scale: 1.05, boxShadow: "0 8px 15px rgba(0,0,0,0.1)" }}>|  
}' src/pages/Prestations.jsx
sed -i 's|</div>|</motion.div>|g' src/pages/Prestations.jsx

# 2) Booster le formulaire Contact
echo "2) Ajout du champ Sujet et wrap Card dans Contact.jsx…"
npm install yup @hookform/resolvers --save
sed -i '/import { useForm }/a import * as yup from "yup"\nimport { yupResolver } from "@hookform\/resolvers\/yup"\nimport Card from "../components\/ui\/Card"' src/pages/Contact.jsx

# Injecte le schema, les erreurs et le nouveau champ "subject"
perl -i -0777 -pe '
  s|(const { register, handleSubmit, reset } = useForm\(\))|const schema = yup.object().shape\({ name: yup.string().required(), email: yup.string().email().required(), subject: yup.string().required(), message: yup.string().required() }\);\n  const { register, handleSubmit, reset, formState: { errors } } = useForm\({ resolver: yupResolver\(schema\) }\);|s;
  s|<form onSubmit=\{handleSubmit\(onSubmit\)\} className="space-y-4">|<form onSubmit={handleSubmit(onSubmit)} className="space-y-4">\
        <input {...register("subject")} placeholder="Sujet" className="w-full border px-3 py-2 rounded" />\
        {errors.subject && <p className="text-red-600 text-sm">{errors.subject.message}</p>}|s;
  s|<div className="mx-auto max-w-md p-6 bg-white rounded-lg shadow">|<Card className="mx-auto max-w-md p-6">|s;
  s|</form>|</form>\n    </Card>|s;
' src/pages/Contact.jsx

# 3) Créer le Footer global
echo "3) Création de src/components/Footer.jsx…"
tee src/components/Footer.jsx > /dev/null << 'EOF'
import React from 'react'
import { FaFacebookF, FaInstagram } from 'react-icons/fa'

export default function Footer() {
  return (
    <footer className="py-6 text-center text-sm text-gray-500 space-y-2">
      <div className="space-x-4">
        <a href="#" className="hover:text-luxeGold"><FaFacebookF /></a>
        <a href="#" className="hover:text-luxeGold"><FaInstagram /></a>
      </div>
      <div>© {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</div>
    </footer>
  )
}
EOF

# Intégrer Footer dans Layout
sed -i '/{children}/a \      <Footer />' src/components/Layout.jsx
sed -i '/import .*Helmet/ a import Footer from ".\/Footer"' src/components/Layout.jsx

# 4) CI/CD status reminder
echo "4) Vérification CI/CD GitHub Action…"
if [ -f .github/workflows/deploy.yml ]; then
  echo " • .github/workflows/deploy.yml : OK"
else
  echo " • ⚠️ .github/workflows/deploy.yml manquant"
fi

# 5) Consent Mode pour l’UE
echo "5) Activation du Consent Mode dans Layout.jsx…"
sed -i '/gtag('"'"'js'"'"', new Date()/a \        gtag("consent","default",{ad_storage:"denied",analytics_storage:"denied"});' src/components/Layout.jsx

echo "✅ Cocktail 5-en-1 terminé ! Relance vite : npm run dev -- --host"
