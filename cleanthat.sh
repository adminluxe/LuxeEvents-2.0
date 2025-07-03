#!/usr/bin/env bash
set -euo pipefail

echo "🌍 Démarrage du setup i18n & Géoloc…"

# 1) Installation de react-i18next et deps
echo "1) Installation de i18n…"
npm install react-i18next i18next i18next-browser-languagedetector --save

# 2) Création des fichiers de traduction de base
echo "2) Génération des fichiers de traduction…"
mkdir -p src/locales/{en,nl,fr}
tee src/locales/fr/common.json > /dev/null << 'EOF'
{
  "hero_title": "Bienvenue chez LuxeEvents",
  "book_now": "Réservez maintenant",
  "newsletter": "Newsletter"
}
EOF
tee src/locales/en/common.json > /dev/null << 'EOF'
{
  "hero_title": "Welcome to LuxeEvents",
  "book_now": "Book now",
  "newsletter": "Newsletter"
}
EOF
tee src/locales/nl/common.json > /dev/null << 'EOF'
{
  "hero_title": "Welkom bij LuxeEvents",
  "book_now": "Boek nu",
  "newsletter": "Nieuwsbrief"
}
EOF

# 3) Configuration i18n dans src/i18n.js
echo "3) Création de src/i18n.js…"
tee src/i18n.js > /dev/null << 'EOF'
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';
import fr from './locales/fr/common.json';
import en from './locales/en/common.json';
import nl from './locales/nl/common.json';

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources: { fr: { common: fr }, en: { common: en }, nl: { common: nl } },
    fallbackLng: 'fr',
    ns: ['common'],
    defaultNS: 'common',
    detection: {
      order: ['querystring','cookie','localStorage','navigator'],
      caches: ['cookie']
    }
  });

export default i18n;
EOF

# 4) Intégration dans index.jsx
echo "4) Injection de i18n dans src/index.jsx…"
sed -i "/import App from/i import './i18n';" src/index.jsx

# 5) Composant LanguageSwitcher
echo "5) Création de LanguageSwitcher.jsx…"
tee src/components/LanguageSwitcher.jsx > /dev/null << 'EOF'
import React from 'react';
import { useTranslation } from 'react-i18next';

export default function LanguageSwitcher() {
  const { i18n } = useTranslation();
  return (
    <select
      value={i18n.language}
      onChange={e => i18n.changeLanguage(e.target.value)}
      className="border px-2 py-1 rounded"
    >
      <option value="fr">FR</option>
      <option value="en">EN</option>
      <option value="nl">NL</option>
    </select>
  );
}
EOF

# 6) Détecter la géoloc et afficher l'heure locale
echo "6) Patch Hero.jsx pour géoloc…"
sed -i "/<div className=\"text-center mt-8\">/a \        {navigator.geolocation && (\n          <LocaleTime />\n        )}" src/components/landing/Hero.jsx

tee src/components/LocaleTime.jsx > /dev/null << 'EOF'
import React, { useEffect, useState } from 'react';

export default function LocaleTime() {
  const [time, setTime] = useState('');
  useEffect(() => {
    navigator.geolocation.getCurrentPosition(pos => {
      const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
      setTime(new Intl.DateTimeFormat('default', { timeStyle: 'short', timeZone: tz }).format(new Date()));
    });
  }, []);
  return <div className="mt-2 text-sm">Heure locale : {time}</div>;
}
EOF

echo "✅ i18n & Géoloc prêts !"
echo "→ Pense à importer <LanguageSwitcher /> et <LocaleTime /> où tu veux."
echo "→ Relance : npm run dev -- --host"
