#!/bin/bash
echo "🔧 Script d’analyse & preview — LuxeEvents Debug Mode"

# 1. Injecte sourcemap: true dans vite.config.js
echo "🛠️  Vérification ou ajout de sourcemap dans vite.config.js…"
if grep -q "sourcemap:" vite.config.js; then
  echo "   🔁 sourcemap déjà présent."
else
  sed -i '/build: {/a \    sourcemap: true,' vite.config.js && echo "   ✅ sourcemap: true ajouté."
fi

# 2. Clean .vite et dist
echo "🧹 Nettoyage du cache local…"
rm -rf dist .vite

# 3. Rebuild
echo "⚙️  Build du projet avec sourcemaps activés…"
pnpm run build || { echo "❌ Build échoué. Corrige l'erreur ci-dessus." ; exit 1; }

# 4. Preview
echo "🔎 Lancement de la preview locale (http://localhost:4173)…"
pnpm run preview &

# 5. Instructions DevTools
echo ""
echo "📍 Ouvre Chrome ou Firefox à http://localhost:4173"
echo "🧭 DevTools > Console : tu verras maintenant l’erreur exacte (avec ligne & fichier source)"
echo ""
echo "💡 Si besoin : clique sur la ligne de l'erreur dans la console pour aller directement au bon fichier."
echo ""

exit 0
