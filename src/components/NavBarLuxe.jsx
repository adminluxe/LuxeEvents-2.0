import React from 'react';

export default function NavBarLuxe() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: NavBarLuxe.jsx</div>
    <header className="fixed top-0 left-0 w-full z-50 bg-black/30 backdrop-blur-md text-white border-b border-white/10">
      <nav className="max-w-6xl mx-auto px-4 py-3 flex justify-between items-center">
        <a href="/" className="text-xl font-bold tracking-wide text-[#d4af37]">
          LuxeEvents
        </a>
        <div className="flex gap-6 text-sm font-medium">
          <a href="#gallery" className="hover:text-[#d4af37]">Galerie</a>
          <a href="#services" className="hover:text-[#d4af37]">Services</a>
          <a href="#quote" className="hover:text-[#d4af37]">Devis</a>
        </div>
    </>
  );
}
