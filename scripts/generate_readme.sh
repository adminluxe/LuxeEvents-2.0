#!/bin/bash

echo "📝 Génération du README.md complet pour LuxeEvents..."

cat <<'MDOC' > ./README.md
# 💎 LuxeEvents – Le luxe à la portée de tous

> Une expérience web immersive, narrative et haut de gamme.

---

## 🚀 Stack & Features

- React 18 + Vite 7
- TailwindCSS + PostCSS (mode dark activé)
- Lottie animation, GSAP, Framer Motion
- Swiper narratif + Timeline magique
- Audio spatial immersif (activable)
- Circular Menu interactif
- Formulaire de devis connecté (Mailgun/Postfix)
- SEO optimisé avec Helmet + OpenGraph
- PWA (manifest, favicon, offline-ready)

---

## 📁 Structure

\`\`\`bash
.
├── public/
├── src/
│   ├── components/
│   ├── pages/
│   └── styles/
├── scripts/
├── vite.config.js
├── tailwind.config.js
├── postcss.config.js
└── README.md
\`\`\`

---

## 🔧 Scripts utiles

| Script                        | Rôle |
|------------------------------|------|
| `deploy-to-luxeevents.sh`    | Build + déploiement prod |
| `setup-dark-luxe.sh`         | Activation DarkMode |
| `enhance-sections-flow.sh`   | Optimisation responsive |
| `polish-ui-luxeevents.sh`    | Nettoyage UI mobile & classes |
| `generate_readme.sh`         | Génération du README 💎 |

---

## 🌐 Déploiement

- Domaine : [https://luxeevents.me](https://luxeevents.me)
- Vercel : `adminluxes-projects/luxeevents`

---

## 🧪 À venir

- Audit Lighthouse
- Revue finale PWA
- Dashboard admin (optionnel)

---

> ✨ Le luxe n’est pas un code, c’est une sensation.
MDOC

echo "✅ README.md généré."
