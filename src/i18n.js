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
