import i18n from "i18next";
import { initReactI18next } from "react-i18next";

const resources = {
  fr: {
    translation: {
      "home.hero.h1": "Le luxe à la portée de tous – Une expérience inoubliable!",
      "nav.home":"Accueil","nav.services":"Services","nav.quote":"Devis","nav.legal":"Mentions légales"
    }
  },
  en: {
    translation: {
      "home.hero.h1": "Luxury within reach – An unforgettable experience!",
      "nav.home":"Home","nav.services":"Services","nav.quote":"Quote","nav.legal":"Legal"
    }
  }
};

i18n
  .use(initReactI18next)
  .init({
    resources,
    lng: (localStorage.getItem("lang") || navigator.language || "fr").startsWith("en") ? "en" : "fr",
    fallbackLng: "fr",
    interpolation: { escapeValue: false }
  });

export default i18n;
