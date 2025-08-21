import React from "react";
import i18n from "../i18n";
export default function LanguageSwitcher() {
  const [lng,setLng] = React.useState(i18n.language || "fr");
  const toggle = () => {
    const next = lng==="fr" ? "en" : "fr";
    i18n.changeLanguage(next);
    localStorage.setItem("lang", next);
    setLng(next);
  };
  return (
    <button
      className="px-3 py-2 rounded-lg ring-1 ring-white/20 bg-white/10 text-white text-sm"
      onClick={toggle}
    >
      {lng.toUpperCase()}
    </button>
  );
}
