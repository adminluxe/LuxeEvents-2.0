#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'full_frontend_rebuilder'. Description à compléter.

set -e

echo "🧹 [1/5] Nettoyage du projet frontend..."

rm -rf build
rm -rf node_modules
rm -f package-lock.json

echo "📦 [2/5] Réinstallation des dépendances..."
npm install

echo "🛠️ [3/5] Reconstruction des fichiers essentiels CRA..."

mkdir -p src

cat > src/App.css <<EOF
body {
  margin: 0;
  padding: 0;
  background-color: #fdfaf5;
  font-family: 'Helvetica Neue', sans-serif;
}
EOF

cat > src/App.js <<EOF
import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <h1>LuxeEvents.me</h1>
      <p>Le luxe, à la portée de tous.</p>
    </div>
  );
}

export default App;
EOF

cat > src/index.js <<EOF
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
EOF

cat > src/index.css <<EOF
body {
  margin: 0;
  padding: 0;
  background-color: #ffffff;
  font-family: sans-serif;
}
EOF

echo "🚀 [4/5] Build de production..."
npm run build

echo "📤 [5/5] Commit & push automatique si build réussi..."
git add src/*.js src/*.css
git commit -m "⚙️ Rebuild complet du frontend CRA avec base clean et fonctionnelle"
git push origin main

echo "✅ Tout est prêt. Le build a été poussé et validé dans la branche main !"
