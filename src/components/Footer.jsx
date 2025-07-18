import React from "react";

export default function Footer() {
  return (
    <footer className="text-center text-white py-6 bg-black/30 backdrop-blur-sm text-sm">
      <p>© 2025 LuxeEvents. Tous droits réservés.</p>
      <p className="mt-2">
        <a href="/mentions-legales" className="underline text-white/70 hover:text-[#d4af37]">Mentions légales</a> |{" "}
        <a href="/rgpd" className="underline text-white/70 hover:text-[#d4af37]">Politique de confidentialité</a>
      </p>
    </footer>
  );
}
