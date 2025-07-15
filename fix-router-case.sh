#!/bin/bash
echo "🔧 Correction route /services & nom de fichier…"

# Renommer le fichier s’il est encore en minuscule
[ -f src/pages/services.jsx ] && mv src/pages/services.jsx src/pages/Services.jsx

# Injecter l'import s’il est manquant
grep -q "import Services from './pages/Services';" src/App.jsx || \
  sed -i "/import RequestQuotePage/a import Services from './pages/Services';" src/App.jsx

# Injecter la route s’il manque
grep -q '<Route path="/services"' src/App.jsx || \
  sed -i '/<Route path="\/media"/a \          <Route path="/services" element={<Services />} />' src/App.jsx

echo "✅ Fichier renommé, import et route /services ajoutés si nécessaire."
