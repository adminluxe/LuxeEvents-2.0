import React from 'react'
export default function Footer() {
  return (
    <footer className="bg-gray-800 text-gray-400 py-6 text-center">
      © {new Date().getFullYear()} LuxeEvents. Tous droits réservés.
    </footer>
  )
}
