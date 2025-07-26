import React from 'react';
import { Link } from 'react-router-dom';

export default function Footer() {
  return (
    <>
    <footer className="bg-black text-white py-8">
      <div className="container mx-auto md:px-8 px-4 text-center space-y-2">
        <p>&copy; {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</p>
        <Link to="/mentions-legales" className="hover:text-gold transition">Mentions légales</Link>
        <Link to="/devis" className="hover:text-gold transition">Demande de devis</Link>
      </div>
    </footer>
    </>
  );
}
