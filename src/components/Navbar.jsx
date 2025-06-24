import React from 'react'
import { Link } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
export default function Navbar(){
  const { t, i18n } = useTranslation()
  return <nav>
    <Link to="/">{t('welcome')}</Link> | 
    <Link to="/events">{t('event')}</Link> |
    <button onClick={()=>i18n.changeLanguage(i18n.language==='en'?'fr':'en')}>
      {i18n.language}
    </button>
  </nav>
}
