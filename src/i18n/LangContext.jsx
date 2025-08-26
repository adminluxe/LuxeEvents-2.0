import React, {createContext, useContext, useEffect, useMemo, useState} from "react";

const LangCtx = createContext(null);

const DICT = {
  fr: {
    langLabel: "Langue",
    badge: "Luxe • Excellence • Innovation",
    servicesTitle: "Services",
    galleryTitle: "Galerie",
    book: "Demander un devis",
    footerAbout: "LuxeEvents orchestre des événements premium — luxe, excellence, innovation.",
    privacy: "Politique de confidentialité",
    legal: "Mentions légales",
    cookies: "Cookies",
    follow: "Suivez-nous",
    contactTitle: "Demande de devis",
    contactIntro: "Détaillez votre projet, on revient vers vous très vite.",
    name: "Nom",
    email: "Email",
    message: "Message",
    send: "Envoyer",
    sentOk: "Merci, votre demande a été envoyée.",
    sentKo: "Désolé, envoi impossible pour le moment.",
    services: [
      { title: "Mariages haut de gamme", desc: "Direction artistique complète, du concept aux détails." },
      { title: "Événements corporate",   desc: "Lancements, séminaires, soirées de gala clés en main." },
      { title: "Expériences privées",     desc: "Anniversaires, fiançailles, moments d’exception." },
      { title: "Scénographie & déco",     desc: "Ambiances signature, matériaux nobles & éclairages." }
    ]
  },
  en: {
    langLabel: "Language",
    badge: "Luxury • Excellence • Innovation",
    servicesTitle: "Services",
    galleryTitle: "Gallery",
    book: "Request a quote",
    footerAbout: "LuxeEvents designs premium events — luxury, excellence, innovation.",
    privacy: "Privacy Policy",
    legal: "Legal",
    cookies: "Cookies",
    follow: "Follow us",
    contactTitle: "Request a quote",
    contactIntro: "Describe your project, we will get back to you shortly.",
    name: "Name",
    email: "Email",
    message: "Message",
    send: "Send",
    sentOk: "Thanks, your request has been sent.",
    sentKo: "Sorry, sending failed for now.",
    services: [
      { title: "High-end weddings", desc: "Full art direction, from concept to details." },
      { title: "Corporate events",  desc: "Launches, offsites, black-tie galas." },
      { title: "Private experiences",desc: "Milestones, engagements, intimate excellence." },
      { title: "Scenography & decor",desc: "Signature atmospheres, fine materials & lights." }
    ]
  }
};

export function LangProvider({children}) {
  const browserLang = (typeof window !== "undefined" && (localStorage.getItem("lx_lang") || navigator.language || "fr").slice(0,2)) || "fr";
  const [lang, setLang] = useState(["fr","en"].includes(browserLang) ? browserLang : "fr");

  useEffect(() => {
    if (typeof window !== "undefined") {
      localStorage.setItem("lx_lang", lang);
      document.documentElement.lang = lang;
    }
  }, [lang]);

  const t = useMemo(() => (key) => (DICT[lang] && DICT[lang][key]) ?? key, [lang]);
  const services = DICT[lang].services;

  const value = useMemo(() => ({ lang, setLang, t, services }), [lang, t, services]);
  return <LangCtx.Provider value={value}>{children}</LangCtx.Provider>;
}

export function useLang() {
  const ctx = useContext(LangCtx);
  if (!ctx) throw new Error("useLang must be used within LangProvider");
  return ctx;
}
