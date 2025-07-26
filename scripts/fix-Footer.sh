#!/bin/bash

FILE="src/components/Footer.jsx"

echo "🩹 Réécriture propre du fichier Footer.jsx"

cat << 'EOL' > "$FILE"
import React from 'react';
import { Link } from 'react-router-dom';

export default function Footer() {
  return (
    <footer className="bg-black text-white py-8">
      <div className="container mx-auto px-4 text-center space-y-2">
        <p>&copy; {new Date().getFullYear()} LuxeEvents. Tous droits réservés.</p>
        <Link to="/mentions-legales" className="hover:text-gold transition">Mentions légales</Link>
        <Link to="/devis" className="hover:text-gold transition">Demande de devis</Link>
      </div>
    </footer>
  );
}
EOL

echo "✅ Footer réparé proprement."

echo "🔁 Rebuild en cours..."
npm run build && vercel --prod --force
