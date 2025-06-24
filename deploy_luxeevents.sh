#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# Création du fichier index.html si inexistant
if [[ ! -f index.html ]]; then
  cat > index.html <<EOF
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>LuxeEvents</title>
</head>
<body>
  <div id="root"></div>
  <script type="module" src="/src/index.jsx"></script>
</body>
</html>
EOF
  echo "✅ index.html créé"
else
  echo "ℹ index.html existe"
fi

# Création des pages React si elles n'existent pas
PAGES="./src/pages"
mkdir -p "$PAGES"
for page in Home.jsx About.jsx Services.jsx Contact.jsx; do
  if [[ ! -f "$PAGES/$page" ]]; then
    cat > "$PAGES/$page" <<EOF
import React${page=="Contact.jsx" && echo ", { useState }"}
export default function ${page%.jsx}() { return <main><h1>${page%.jsx}</h1></main>; }
EOF
    echo "✨ $page créé"
  else
    echo "✅ $page existe"
  fi
done

# Renommage de App.js en App.jsx si nécessaire
if [[ -f src/App.js && ! -f src/App.jsx ]]; then
  mv src/App.js src/App.jsx
  echo "🔧 src/App.js renommé → App.jsx pour JSX"
fi

# Configuration de Vite et installation des dépendances
if [[ ! -f .npmrc ]]; then
  echo "legacy-peer-deps=true" > .npmrc
fi

if [[ ! -f vite.config.js ]]; then
  cat > vite.config.js <<EOF
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/'
})
EOF
fi

npm install react-router-dom react-i18next i18next --legacy-peer-deps

# Construction et prévisualisation du projet
npm run build
npm run preview & sleep 3 && kill $! || true

# Déploiement sur Vercel
vercel build --prod --yes
DEPLOY_URL=$(vercel deploy --prebuilt --archive=tgz --prod --yes)
echo "✅ Déployé sur : $DEPLOY_URL"

# Test final avec curl
curl -I https://www.luxeevents.me || true
