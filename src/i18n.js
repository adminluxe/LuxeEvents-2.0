import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

import en from './locales/en.json.js';
import fr from './locales/fr.json.js';

i18n
  .use(initReactI18next)
  .init({
    resources: { en: { translation: en }, fr: { translation: fr } },
    lng: 'fr', // langue par défaut
    fallbackLng: 'fr',
    interpolation: { escapeValue: false },
  });

export default i18n;
