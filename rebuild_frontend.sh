#!/bin/bash

echo "🔧 Réinitialisation des fichiers de base React CRA..."

# 1. Crée ou écrase les fichiers de base
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
    <div>
      <h1>Bienvenue sur luxeEvents.me ✨</h1>
      <p>Le luxe, à la portée de tous.</p>
    </div>
  );
}

export default App;
EOF

cat > src/index.css <<EOF
body {
  margin: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
EOF

cat > src/index.js <<EOF
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

echo "✅ Fichiers créés."

# 2. Ajouter à Git
git add -f src/App.css src/App.js src/index.css src/index.js
git commit -m "🧱 Reconstruction complète des fichiers CRA de base"
git push origin main

# 3. Build
echo "🏗️  Lancement du build de production..."
npm run build

echo "🎉 Tout est prêt, Tonton ! Le frontend est reconstruit et compilé."
