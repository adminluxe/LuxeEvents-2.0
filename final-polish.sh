#!/bin/bash

echo "🎨 Application des retouches finales LuxeEvents..."

# 💅 Retarder l'apparition du menu circulaire (scrollY > 200)
sed -i 's|if (window.scrollY > 100)|if (window.scrollY > 200)|' src/components/CircularMenu.jsx

# 🔇 Réduire la profondeur d’arrière-plan du bouton (plus léger)
sed -i 's|bg-black/70|bg-black/50|' src/components/CircularMenu.jsx

# ↕️ Plus d’espace entre les boutons circulaires
sed -i 's|space-y-3|space-y-4|' src/components/CircularMenu.jsx

# 📱 Améliorer la zone tactile sur mobile
sed -i 's|p-4|p-6|' src/components/CircularMenu.jsx

echo "✅ Retouches appliquées. Relance avec pnpm run build && vercel --prod"
