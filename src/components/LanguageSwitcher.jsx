import React from 'react';
import { useTranslation } from 'react-i18next';

export default function LanguageSwitcher() {
  const { i18n } = useTranslation();
  return (
    <select
      value={i18n.language}
      onChange={e => i18n.changeLanguage(e.target.value)}
      className="border px-2 py-1 rounded"
    >
      <option value="fr">FR</option>
      <option value="en">EN</option>
      <option value="nl">NL</option>
    </select>
  );
}
