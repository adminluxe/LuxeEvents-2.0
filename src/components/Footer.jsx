import React from "react";
export default function Footer(){
  return (
    <footer className="mt-16 border-t border-white/10 py-10 text-sm text-white/70">
      <div className="container mx-auto px-4 flex flex-col sm:flex-row gap-4 sm:gap-8 justify-between">
        <div>© LuxeEvents · {new Date().getFullYear()}</div>
        <nav className="flex gap-4">
          <a href="/a-propos" className="hover:underline">Qui sommes-nous</a>
          <a href="/mentions-legales" className="hover:underline">Mentions légales</a>
          <a href="/politique-confidentialite" className="hover:underline">Politique de confidentialité</a>
        </nav>
      </div>
    </footer>
  );
}
