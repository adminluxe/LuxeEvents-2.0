import LanguageSwitcher from "@/components/LanguageSwitcher";
import ThemeToggle from "@/components/ThemeToggle";
import CircularMenu from "@/components/CircularMenu";
import { Link } from "react-router-dom";
export default function Navbar(){
  return (
    <header className="fixed top-0 inset-x-0 z-40 bg-black/50 backdrop-blur border-b border-amber-500">
      <nav className="max-w-6xl mx-auto px-4 py-3 flex items-center justify-between">
        <Link to="/" className="text-xl font-semibold text-amber-400">LuxeEvents</Link>
        <div className="hidden md:flex gap-6 text-sm">
          <Link to="/" className="hover:text-amber-400">Accueil</Link>
          <Link to="/services" className="hover:text-amber-400">Services</Link>
          <Link to="/gallery" className="hover:text-amber-400">Galerie</Link>
          <Link to="/devis" className="hover:text-amber-400">Devis</Link>
          <Link to="/contact" className="hover:text-amber-400">Contact</Link>
        </div>
        <div className="flex items-center gap-2"><LanguageSwitcher/><ThemeToggle/></div>
      </nav>
      <CircularMenu/>
    </header>
  );
}
