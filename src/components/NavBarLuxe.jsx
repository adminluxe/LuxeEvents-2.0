import React from "react";
import { Link } from "react-router-dom";

export default function NavBarLuxe() {
  return (
    <header className="fixed top-0 left-0 w-full z-50 bg-black/30 backdrop-blur-md text-white border-b border-white/10">
      <nav className="max-w-6xl mx-auto px-4 py-3 flex justify-between items-center">
        <Link to="/" className="text-xl font-bold tracking-wide text-[#d4af37]">
          LuxeEvents
        </a>
        <div className="flex gap-6 text-sm font-medium">
          <Link to="/media" className="hover:text-[#d4af37]">Galerie</a>
          <Link to="/services" className="hover:text-[#d4af37]">Services</a>
          <Link to="/quote" className="hover:text-[#d4af37]">Devis</a>
        </div>
      </nav>
    </header>
  );
}
