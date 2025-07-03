import React from 'react'
import { FaFacebookF, FaInstagram } from 'react-icons/fa'

export default function Footer() {
  return (
    <footer className="py-6 text-center text-sm text-gray-500 space-y-2">
      <div className="space-x-4">
        <a href="#" className="hover:text-luxeGold"><FaFacebookF /></a>
        <a href="#" className="hover:text-luxeGold"><FaInstagram /></a>
      </div>
      <div>© {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</div>
    </footer>
  )
}
