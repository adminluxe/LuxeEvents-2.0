import { useTranslation } from "react-i18next";
export default function LanguageSwitcher(){
  const { i18n } = useTranslation();
  const toggle = () => { const next = i18n.language === "fr" ? "en" : "fr"; i18n.changeLanguage(next); try{localStorage.setItem("lang",next);}catch{} };
  return <button aria-label="Change language" className="px-3 py-1 rounded-full border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-black transition" onClick={toggle}>{i18n.language?.toUpperCase()||"FR"}</button>;
}
