#!/bin/bash

echo "🚨 Lancement du nettoyage express LuxeEvents..."

# 🔁 Harmonisation de 'Media' -> 'Médias'
echo "🔤 Harmonisation des termes : Media → Médias"
grep -rl 'label: .Media' src/ | xargs sed -i 's/label: .Media/label: '\''Médias'\''/g'
grep -rl '>Media<' src/ | xargs sed -i 's/>Media</>Médias</g'
grep -rl '"Media"' src/ | xargs sed -i 's/"Media"/"Médias"/g'
grep -rl "'Media'" src/ | xargs sed -i "s/'Media'/'Médias'/g"

# 🧹 Suppression des lignes en double href= vers pages principales sauf Navbar/Footer
echo "🧽 Suppression des href doublons dans les composants..."
FILES=$(find src/components -name "*.jsx" ! -name "Navbar.jsx" ! -name "Footer.jsx")

for file in $FILES; do
  sed -i '/href="\/media"/{x;/./d;x;d;}' "$file"
  sed -i '/href="\/services"/{x;/./d;x;d;}' "$file"
  sed -i '/href="\/demande-de-devis"/{x;/./d;x;d;}' "$file"
done

# 🗑️ Suppression du mauvais fichier Services
if [ -f "src/pages/ServicesPage.jsx" ] && [ -f "src/pages/Services.jsx" ]; then
  echo "🧠 Les deux fichiers Services existent. On garde ServicesPage.jsx."
  rm src/pages/Services.jsx
  echo "✅ src/pages/Services.jsx supprimé."
fi

# 🔍 Mise à jour des imports dans App.jsx
echo "📦 Vérification et mise à jour de src/App.jsx"
sed -i '/import Services from .\/pages\/Services/d' src/App.jsx
sed -i 's/<Services \/>/<ServicesPage \/>/g'

echo "✅ Nettoyage terminé. Relance ton app avec pnpm run dev"
