import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

import fr from "@/locales/fr/fr.json";
import en from "@/locales/en/en.json";

i18n.use(initReactI18next).init({
  resources: {
    fr,
    en,
  },
  lng: 'fr',
  fallbackLng: 'fr',
  interpolation: {
    escapeValue: false,
  },
});

export default i18n;
