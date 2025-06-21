#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'check_structure'. Description à compléter.

echo "🚀 Vérification et remise en ordre de la structure Vite du projet Luxeevents-frontend"

BASE_DIR="$(pwd)"

# Vérifie/crée dossier public
if [ ! -d "$BASE_DIR/public" ]; then
  mkdir "$BASE_DIR/public"
  echo "📁 Création dossier : public"
else
  echo "✅ Dossier existe : public"
fi

# Vérifie/crée index.html dans public
if [ ! -f "$BASE_DIR/public/index.html" ]; then
  cat > "$BASE_DIR/public/index.html" <<EOF
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Luxeevents</title>
</head>
<body>
  <div id="root"></div>
  <script type="module" src="/src/index.js"></script>
</body>
</html>
EOF
  echo "📄 Fichier créé : public/index.html"
else
  echo "✅ Fichier existe : public/index.html"
fi

# Vérifie/crée dossier src
if [ ! -d "$BASE_DIR/src" ]; then
  mkdir "$BASE_DIR/src"
  echo "📁 Création dossier : src"
else
  echo "✅ Dossier existe : src"
fi

# Vérifie/crée src/index.js
if [ ! -f "$BASE_DIR/src/index.js" ]; then
  cat > "$BASE_DIR/src/index.js" <<EOF
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
EOF
  echo "📄 Fichier créé : src/index.js"
else
  echo "✅ Fichier existe : src/index.js"
fi

# Vérifie/crée src/App.js
if [ ! -f "$BASE_DIR/src/App.js" ]; then
  cat > "$BASE_DIR/src/App.js" <<EOF
import React from 'react';

function App() {
  return (
    <div>
      <h1>Bienvenue sur Luxeevents</h1>
    </div>
  );
}

export default App;
EOF
  echo "📄 Fichier créé : src/App.js"
else
  echo "✅ Fichier existe : src/App.js"
fi

# Vérifie/crée dossier src/components
if [ ! -d "$BASE_DIR/src/components" ]; then
  mkdir "$BASE_DIR/src/components"
  echo "📁 Création dossier : src/components"
else
  echo "✅ Dossier existe : src/components"
fi

# Vérifie/crée dossier src/i18n
if [ ! -d "$BASE_DIR/src/i18n" ]; then
  mkdir "$BASE_DIR/src/i18n"
  echo "📁 Création dossier : src/i18n"
else
  echo "✅ Dossier existe : src/i18n"
fi

# Vérifie/crée src/i18n/en.json
if [ ! -f "$BASE_DIR/src/i18n/en.json" ]; then
  echo '{}' > "$BASE_DIR/src/i18n/en.json"
  echo "📄 Fichier créé : src/i18n/en.json"
else
  echo "✅ Fichier existe : src/i18n/en.json"
fi

# Vérifie/crée src/i18n/fr.json
if [ ! -f "$BASE_DIR/src/i18n/fr.json" ]; then
  echo '{}' > "$BASE_DIR/src/i18n/fr.json"
  echo "📄 Fichier créé : src/i18n/fr.json"
else
  echo "✅ Fichier existe : src/i18n/fr.json"
fi

echo "🎉 Structure vérifiée et remise en ordre. Prêt pour Vite !"
