#!/usr/bin/env bash
set -e

echo "🚀 1. Création du dossier public/icons et stubs SVG…"
mkdir -p public/icons
for ico in menu close home; do
  file=public/icons/\${ico}.svg
  if [ ! -f "\$file" ]; then
    cat > "\$file" << 'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
  <rect width="24" height="24" fill="lightgray" />
</svg>
SVG
    echo "   → stub \$ico.svg créé"
  else
    echo "   ℹ \$ico.svg existe déjà, skip"
  fi
done

echo
echo "🛠 2. Patch src/components/Navbar.jsx : import des icônes et aria-*…"
NAV=src/components/Navbar.jsx
if [ -f "\$NAV" ]; then
  # 2.1 Import des icônes SVG
  if ! grep -q "public/icons/menu.svg" "\$NAV"; then
    sed -i "/import React/a\\
import menuIcon from '../../public/icons/menu.svg'\\
import closeIcon from '../../public/icons/close.svg'\\
import homeIcon from '../../public/icons/home.svg'" "\$NAV"
    echo "   → imports SVG ajoutés"
  else
    echo "   ℹ imports SVG déjà présents"
  fi
  # 2.2 Remplacer placeholder img src par ces variables
  sed -i "s|src=\"[^\"]*menu\\.svg\"|src={menuIcon}|g" "\$NAV"
  sed -i "s|src=\"[^\"]*close\\.svg\"|src={closeIcon}|g" "\$NAV"
  sed -i "s|src=\"[^\"]*home\\.svg\"|src={homeIcon}|g" "\$NAV"
  echo "   → src=…menu.svg remplacés par menuIcon, etc."
else
  echo "❌ \$NAV introuvable"
fi

echo
echo "🔄 3. Vérification de src/App.jsx : Navbar et route RGPD…"
APP=src/App.jsx
if [ -f "\$APP" ]; then
  # 3.1 S'assurer que Navbar est importé
  if ! grep -q "import Navbar" "\$APP"; then
    sed -i "1s|^|import Navbar from './components/Navbar'\\n|" "\$APP"
    echo "   → Navbar importé"
  fi
  # 3.2 Ajouter route RGPD si manquante
  if ! grep -q "politique-confidentialite" "\$APP"; then
    sed -i "/<Routes>/a\\
          <Route path=\"/politique-confidentialite\" element={<div>Politique RGPD…</div>} />" "\$APP"
    echo "   → route /politique-confidentialite ajoutée"
  else
    echo "   ℹ route RGPD déjà présente"
  fi
else
  echo "❌ \$APP introuvable"
fi

echo
echo "✅ Tout est à jour ! Relance le dev : pnpm run dev"
