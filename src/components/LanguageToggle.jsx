import React from 'react';
import i18n from 'i18next';

export default function LanguageToggle() {
  const [lng, setLng] = React.useState(i18n.language || 'fr');
  const switchTo = (code) => () => { i18n.changeLanguage(code); setLng(code); localStorage.setItem('lng', code); };

  return (
    <div className="flex gap-2 items-center text-sm rounded-full px-3 py-2 bg-white/70 dark:bg-black/40 backdrop-blur shadow">
      <button onClick={switchTo('fr')} className={`font-medium ${lng==='fr'?'underline':''}`}>FR</button>
      <span>·</span>
      <button onClick={switchTo('en')} className={`font-medium ${lng==='en'?'underline':''}`}>EN</button>
    </div>
  );
}
