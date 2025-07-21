#!/bin/bash

echo "🌐 Installation des dépendances i18n..."
npm install i18next react-i18next

echo "📁 Création de la structure de traductions..."
mkdir -p src/locales/fr src/locales/en

cat > src/locales/fr/translation.json <<EOF
{
  "hero.title": "Sublimez votre événement",
  "quote.cta": "Demander un devis"
}
EOF

cat > src/locales/en/translation.json <<EOF
{
  "hero.title": "Enhance your event",
  "quote.cta": "Request a quote"
}
EOF

cat > src/i18n.js <<EOF
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import fr from './locales/fr/translation.json';
import en from './locales/en/translation.json';

i18n.use(initReactI18next).init({
  resources: {
    fr: { translation: fr },
    en: { translation: en }
  },
  lng: 'fr',
  fallbackLng: 'fr',
  interpolation: { escapeValue: false }
});

export default i18n;
EOF

echo "🧠 Injection dans main.jsx..."
sed -i '1i\
import "./i18n";' src/main.jsx

echo "✅ Multilingue activé ! Utilise {t(\"hero.title\")} avec useTranslation()"

echo "💡 Exemple dans un composant :\n\
import { useTranslation } from \"react-i18next\";\n\
const { t, i18n } = useTranslation();\n\
<p>{t(\"hero.title\")}</p>"

echo "🌍 Ajoute `i18n.changeLanguage('en')` dans le bouton 🌐"
