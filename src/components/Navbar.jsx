import React from 'react';
import { Link } from 'react-router-dom';

export default function Navbar() {
  return (
    <header className="fixed top-0 left-0 right-0 bg-white/80 backdrop-blur-md border-b border-yellow-300 shadow z-50">
      <nav className="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <Link to="/" className="text-2xl font-black tracking-wide text-yellow-500 hover:text-yellow-600 transition duration-300">
          Luxe<span className="text-black">Events</span>
        </Link>
        <ul className="flex gap-6 text-sm font-medium text-gray-700">
          <li><Link to="/media" className="hover:text-yellow-500 transition">Media</Link></li>
          <li><Link to="/services" className="hover:text-yellow-500 transition">Services</Link></li>
          <li><Link to="/demande-de-devis" className="hover:bg-yellow-500 hover:text-white transition bg-yellow-400 text-white px-3 py-1 rounded-md shadow-sm">Devis</Link></li>
        </ul>
      </nav>
    </header>
  );
}
