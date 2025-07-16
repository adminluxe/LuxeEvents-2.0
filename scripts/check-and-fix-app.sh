#!/bin/bash

echo "🔎 Vérification et réparation de src/App.jsx..."

APP_FILE="src/App.jsx"
CIRCULAR_MENU_FILE="src/components/CircularMenu.jsx"
HOOK_FILE="src/hooks/useSwipeNavigation.js"

# 1. Vérifie et ajoute les imports manquants
grep -q "AnimatePresence" "$APP_FILE" || sed -i '/react-router-dom/a import { AnimatePresence, motion } from '\''framer-motion'\'';' "$APP_FILE"
grep -q "CircularMenu" "$APP_FILE" || sed -i '/Footer/a import CircularMenu from '\''./components/CircularMenu'\'';' "$APP_FILE"
grep -q "useSwipeNavigation" "$APP_FILE" || sed -i '/Footer/a import useSwipeNavigation from '\''./hooks/useSwipeNavigation'\'';' "$APP_FILE"

# 2. Vérifie que useSwipeNavigation est appelé
grep -q "useSwipeNavigation();" "$APP_FILE" || sed -i '/function App()/a \ \ useSwipeNavigation();' "$APP_FILE"

# 3. Vérifie que CircularMenu est dans le JSX
grep -q "<CircularMenu" "$APP_FILE" || sed -i '/<Footer \/>/a \ \ \ \ <CircularMenu />' "$APP_FILE"

# 4. Génère CircularMenu.jsx si manquant
if [ ! -f "$CIRCULAR_MENU_FILE" ]; then
  echo "⚙️ Génération du fichier CircularMenu.jsx manquant..."
  mkdir -p src/components && cat > "$CIRCULAR_MENU_FILE" <<'EOF'
import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { motion } from 'framer-motion';

export default function CircularMenu() {
  const location = useLocation();
  const pages = [
    { path: "/", label: "Accueil" },
    { path: "/media", label: "Media" },
    { path: "/services", label: "Services" },
    { path: "/demande-de-devis", label: "Devis" },
  ];

  return (
    <div className="fixed bottom-8 right-8 z-50">
      <div className="relative w-16 h-16 group">
        <div className="absolute inset-0 bg-yellow-500 rounded-full shadow-lg group-hover:scale-110 transition"></div>
        {pages.map((p, i) => (
          <motion.div
            key={p.path}
            initial={{ scale: 0 }}
            animate={{
              scale: 1,
              x: -70 * Math.cos(i * 2 * Math.PI / pages.length),
              y: -70 * Math.sin(i * 2 * Math.PI / pages.length)
            }}
            transition={{ delay: i * 0.05 }}
            className="absolute w-10 h-10 bg-white rounded-full shadow flex items-center justify-center text-xs text-yellow-600 font-semibold"
          >
            <Link to={p.path}>{p.label}</Link>
          </motion.div>
        ))}
      </div>
    </div>
  );
}
EOF
  echo "✅ CircularMenu.jsx généré avec succès."
else
  echo "✅ CircularMenu.jsx déjà présent."
fi

echo "✅ App.jsx réparé avec succès. Tu peux relancer ton build ✨"
