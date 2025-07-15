#!/bin/bash

echo "🔧 Correction et diagnostic du bug /services…"

# Étape 1 : Correction du nom de fichier
if [ -f src/pages/services.jsx ]; then
  mv src/pages/services.jsx src/pages/Services.jsx
  echo "✅ Fichier renommé en Services.jsx"
fi

# Étape 2 : Vérification de l'import
grep -q "import Services from './pages/Services';" src/App.jsx || \
  sed -i "/import RequestQuotePage/a import Services from './pages/Services';" src/App.jsx

# Étape 3 : Vérification de la route
grep -q '<Route path="/services"' src/App.jsx || \
  sed -i '/<Route path="\/media"/a \          <Route path="/services" element={<Services />} />' src/App.jsx

echo "✅ Import & route vérifiés dans App.jsx"

# Étape 4 : Remplacement temporaire du composant Services
cat > src/pages/Services.jsx <<'EOC'
import React from 'react';
export default function Services() {
  return (
    <div style={{ padding: '2rem', fontSize: '1.5rem', color: 'green' }}>
      ✅ Composant <strong>Services</strong> chargé avec succès.
    </div>
  );
}
EOC

echo "✅ Version mock de Services.jsx injectée pour test visuel."

# Étape 5 : Vérifie si les traductions sont là
add_if_missing() {
  FILE=$1
  KEY=$2
  VALUE=$3
  if ! grep -q "\"$KEY\"" "$FILE"; then
    sed -i "s/^{/  \"$KEY\": \"$VALUE\",\n&/" "$FILE"
    echo "➕ Ajout: $KEY → $FILE"
  fi
}

add_if_missing public/locales/fr/fr.json services.title "Nos services"
add_if_missing public/locales/fr/fr.json services.cta "Pour un devis personnalisé, contactez-nous sans attendre."
add_if_missing public/locales/en/en.json services.title "Our Services"
add_if_missing public/locales/en/en.json services.cta "For a custom quote, contact us today."

# Étape 6 : Vérifie sourcemap dans vite.config.js
grep -q "sourcemap: true" vite.config.js || \
  sed -i '/build:/a \    sourcemap: true,' vite.config.js && \
  echo "✅ Sourcemap activé dans vite.config.js"

echo "🧼 Nettoyage terminé. Tu peux maintenant relancer le build et la preview :"
echo ""
echo "   pnpm run build && pnpm run preview"
echo ""
echo "🧭 Va sur http://localhost:4173 (ou 4174/4175)"
echo "➡️  Si tout fonctionne avec la version mock, on remettra la vraie version finale de Services.jsx !"
