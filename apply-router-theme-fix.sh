#!/usr/bin/env bash
set -euo pipefail

# 1) Sauvegardes
echo "🔒 Sauvegarde de main.jsx et App.jsx"
mkdir -p migrations
cp src/main.jsx migrations/main.jsx.bak
cp src/App.jsx  migrations/App.jsx.bak

# 2) Patch main.jsx pour BrowserRouter
cat > src/main.jsx << 'EOF'
import React from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App'

// Rendu root avec Router
createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
)
EOF
echo "✅ src/main.jsx mis à jour avec <BrowserRouter>"

# 3) Patch App.jsx pour ThemeProvider
# On suppose que tu as un provider nommé ThemeProvider dans ./hooks/useTheme.js ou ./contexts/ThemeContext.js
# Si tu utilises un provider différent, adapte le import.
cat > src/App.jsx << 'EOF'
import React from 'react'
import { ThemeProvider } from './hooks/useTheme'  // ou './contexts/ThemeContext'
import { Routes, Route } from 'react-router-dom'
import Home from './pages/index'
import About from './pages/about'
import Contact from './pages/contact'
// ... tes autres imports de pages

export default function App() {
  return (
    <ThemeProvider>
      <Routes>
        <Route path='/' element={<Home />} />
        <Route path='/about' element={<About />} />
        <Route path='/contact' element={<Contact />} />
        {/* ... tes autres routes */}
      </Routes>
    </ThemeProvider>
  )
}
EOF
echo "✅ src/App.jsx mis à jour avec <ThemeProvider> et <Routes>"

# 4) Permissions et instructions suivantes
chmod +x apply-router-theme-fix.sh
echo -e "\n🔧 Script apply-router-theme-fix.sh prêt. Exécute :\n  ./apply-router-theme-fix.sh\npuis relance :\n  pnpm run dev\n  pnpm run build && pnpm run preview\n"
