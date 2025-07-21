import { Link } from "react-router-dom";

export default function Footer() {
  return (
    <footer className="bg-black text-neutral-300 py-10 px-4 text-sm text-center border-t border-neutral-800">
      <div className="max-w-6xl mx-auto space-y-4">
        <p className="text-neutral-400 text-base">
          © 2025 <span className="text-gold font-semibold">LuxeEvents</span> — Tous droits réservés.
        </p>
        <div className="space-x-4">
          <Link to="/mentions-legales" className="hover:text-gold transition">Mentions légales</Link>
          <Link to="/devis" className="hover:text-gold transition">Demande de devis</Link>
        </div>
      </div>
    </footer>
  );
}
