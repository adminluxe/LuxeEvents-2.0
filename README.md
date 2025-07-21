# LuxeEvents 2.0

💎 Plateforme immersive haut de gamme pour l'organisation d'événements exceptionnels : mariages, culturels, corporate.

> "Le luxe à la portée de tous, une expérience web comme jamais vue."

---

## 🎯 Fonctionnalités V1

- Hero animé (GSAP + Lottie)
- Audio spatial activable
- Swiper narratif + Timeline magique
- Formulaire de devis interactif & connecté
- Footer immersif avec lien vers toutes les sections
- Menu circulaire réactif (Accueil / Devis / Langue)
- Expérience scroll nouvelle génération
- Transitions de page (React Router)
- Support multilingue (FR / EN)
- Thématisation gold avec Tailwind custom
- Scripts shell d’automation (injection, fix, deploy)

---

## 🚀 Lancer le projet en local

```bash
npm install
npm run dev
```

> Accédez à : [http://localhost:5173](http://localhost:5173)

---

## 🌐 Pages disponibles

| Route         | Description                             |
|---------------|------------------------------------------|
| `/`           | Page d'accueil immersive                 |
| `/devis`      | Formulaire de demande de devis           |
| `/mariage`    | (Placeholder) Page mariage               |
| `/corporate`  | (Placeholder) Page événement pro         |
| `/culturel`   | (Placeholder) Page événement culturel     |

---

## 🌍 Multilingue (i18n)

Utilise `i18next` + `react-i18next`

Traductions dans `src/locales/fr/translation.json` et `en/`

```js
import { useTranslation } from "react-i18next";
const { t } = useTranslation();
<p>{t("hero.title")}</p>
```

Changer de langue : bouton 🌐 dans le `CircularMenu`

---

## 🧪 Scripts utiles

```bash
bash scripts/fix-i18n-corruption.sh     # Répare le i18n + JSX + cache vite
bash scripts/inject-circular-menu-items.sh
bash scripts/activate-i18n.sh
bash scripts/deploy-final-v1.sh         # Build + Vercel + Open
```

---

## 🧾 Structure du projet

```
src/
  components/      // Tous les composants React (Hero, Footer, etc)
  pages/           // Pages routables (devis.jsx, etc)
  locales/         // Traductions FR / EN
  i18n.js          // Config internationale
  App.jsx          // Routing principal
  main.jsx         // Entrée Vite
```

---

## 🌟 Déploiement Vercel

```bash
bash scripts/deploy-final-v1.sh
```

La commande gère :
- Build
- SEO
- Favicon
- Push Vercel prod
- Ouverture automatique du site

---

## 🛡 By Purple Orchid Group x Tonton

*Raffinement, excellence, expérience next-gen.*
