import { createContext, useContext, useEffect, useState } from "react";
const LangContext = createContext({ lang: "fr", setLang: () => {} });
export const LangProvider = ({ children }) => {
  const [lang, setLang] = useState(() => localStorage.getItem("lang") || "fr");
  useEffect(() => { localStorage.setItem("lang", lang); document.documentElement.lang = lang; }, [lang]);
  return <LangContext.Provider value={{ lang, setLang }}>{children}</LangContext.Provider>;
};
export const useLang = () => useContext(LangContext);
