import React from "react";
import { Link } from "react-router-dom";

export default function FooterLuxe() {
  return (
    <footer className="bg-black text-white text-sm py-6 px-4 text-center border-t border-white/10">
      <div className="max-w-4xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
        <p>&copy; {new Date().getFullYear()} LuxeEvents – Tous droits réservés.</p>
        <div className="flex gap-4">
          <Link to="/legal" className="hover:text-[#d4af37]">Mentions légales</Link>
          <a href="mailto:contact@luxeevents.me" className="hover:text-[#d4af37]">contact@luxeevents.me</a>
        </div>
      </div>
    </footer>
  );
}
