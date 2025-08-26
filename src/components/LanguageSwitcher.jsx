import React from "react";
const setLang = (lang) => {
  try {
    document.documentElement.lang = lang;
    document.documentElement.setAttribute('data-locale', lang);
    localStorage.setItem('lang', lang);
    window.dispatchEvent(new Event('langchange'));
  } catch {}
};
export default function LanguageSwitcher(){
  const [lang,setState] = React.useState(localStorage.getItem('lang')||'fr');
  const click = (l)=>()=>{ setState(l); setLang(l); };
  return (
    <div className="inline-flex rounded-full shadow bg-white/90 dark:bg-zinc-900/80 backdrop-blur border border-zinc-200 dark:border-zinc-800 overflow-hidden">
      <button onClick={click('fr')} className={`px-3 py-1 ${lang==='fr'?'font-semibold':''}`}>FR</button>
      <button onClick={click('en')} className={`px-3 py-1 ${lang==='en'?'font-semibold':''}`}>EN</button>
    </div>
  );
}
