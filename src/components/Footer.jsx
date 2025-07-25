import React from 'react';

export default function Footer() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: Footer.jsx</div>
    <footer className="bg-black text-neutral-300 py-10 px-4 text-sm text-center border-t border-neutral-800">
      <div className="max-w-6xl mx-auto space-y-4">
        <p className="text-neutral-400 text-base">
          © 2025 <span className="text-gold font-semibold">LuxeEvents</span> — Tous droits réservés.
        </p>
        <div className="space-x-4">
          <Link to="/mentions-legales" className="hover:text-gold transition">Mentions légales</Link>
          <Link to="/devis" className="hover:text-gold transition">Demande de devis</Link>
        </div>
    </>
  );
}
