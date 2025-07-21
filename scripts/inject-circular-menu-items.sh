#!/bin/bash

MENU="src/components/CircularMenu.jsx"

if ! grep -q "to=\"/devis\"" "$MENU"; then
  echo "✨ Injection des liens Accueil / Devis / Langue dans CircularMenu.jsx..."

  sed -i '1i\
import { Link } from "react-router-dom";' "$MENU"

  sed -i '/return (/a\
      <div className="flex flex-col items-center gap-4">\n\
        <Link to="/" className="text-white hover:text-gold transition">🏠 Accueil</Link>\n\
        <Link to="/devis" className="text-white hover:text-gold transition">📩 Devis</Link>\n\
        <button onClick={toggleLanguage} className="text-white hover:text-gold transition">🌐 Langue</button>\n\
      </div>' "$MENU"

  echo "✅ Liens ajoutés."
else
  echo "✅ Les boutons sont déjà présents dans CircularMenu.jsx"
fi
