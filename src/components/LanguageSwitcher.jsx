import { useLang } from "../i18n/LangContext";
export default function LanguageSwitcher({ className="" }) {
  const { lang, setLang } = useLang();
  const next = lang === "fr" ? "en" : "fr";
  return (
    <button aria-label="Change language"
      className={`px-3 py-1 rounded-full border text-sm ${className}`}
      onClick={() => setLang(next)}>
      {lang.toUpperCase()} ▸ {next.toUpperCase()}
    </button>
  );
}
