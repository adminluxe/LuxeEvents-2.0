import { useEffect, useState } from "react";

const SUPPORTED = ["fr", "en"];

export default function LangToggle({ className = "" }) {
  const [lang, setLang] = useState(() => {
    const saved = localStorage.getItem("lang");
    return SUPPORTED.includes(saved) ? saved : "fr";
  });

  useEffect(() => {
    document.documentElement.setAttribute("lang", lang);
    localStorage.setItem("lang", lang);
    // i18next (si présent)
    if (window.i18next && typeof window.i18next.changeLanguage === "function") {
      try { window.i18next.changeLanguage(lang); } catch {}
    }
    // Event global pour composants custom
    try { window.dispatchEvent(new CustomEvent("langchange", { detail: { lang } })); } catch {}
  }, [lang]);

  const next = lang === "fr" ? "en" : "fr";
  return (
    <button
      type="button"
      onClick={() => setLang(next)}
      className={"px-3 py-2 rounded-xl border text-sm shadow-sm hover:opacity-90 transition " +
        "bg-white/90 dark:bg-black/40 border-black/10 dark:border-white/10 " + className}
      title="Language"
    >
      {lang.toUpperCase()} · {next.toUpperCase()}
    </button>
  );
}
