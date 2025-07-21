#!/bin/bash

echo "🚀 Patch global LuxeEvents"

# 1. Corriger Media > Médias (et éviter les apostrophes doubles)
sed -i "s/label: 'Médias''/label: 'Médias'/g" src/components/CircularMenu.jsx
grep -rl "label: 'Media'" src/ | xargs sed -i "s/label: 'Media'/label: 'Médias'/g"
grep -rl '>Media<' src/ | xargs sed -i 's/>Media</>Médias</g'

# 2. Supprimer imports et composants <Services /> orphelins
sed -i "/import Services from '.\/pages\/Services';/d" src/App.jsx
sed -i '/<Services \/>/d' src/App.jsx

# 3. Confirmation
echo "✅ Tous les correctifs ont été appliqués. Redémarre avec pnpm run dev"
