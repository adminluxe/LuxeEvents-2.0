#!/bin/bash

echo "🚀 Déploiement complet LuxeEvents en cours..."
echo "----------------------------------------------"

# Vérifie que Vercel CLI est installé
if ! command -v vercel &> /dev/null
then
    echo "❌ Vercel CLI non trouvé. Installe avec: npm i -g vercel"
    exit 1
fi

# Vérifie la présence du fichier vercel.json
if [ ! -f vercel.json ]; then
  echo "⚠️  Aucun fichier vercel.json trouvé. Utilisation des paramètres par défaut."
fi

# Lien du projet (seulement si non lié)
if [ ! -d ".vercel" ]; then
  echo "🔗 Aucun lien Vercel détecté. Lancement de la commande vercel link..."
  vercel link || { echo '❌ Échec du lien Vercel'; exit 1; }
else
  echo "✅ Projet déjà lié à Vercel."
fi

# Lancement du déploiement
echo "🚢 Déploiement production (vercel --prod)..."
vercel --prod || { echo '❌ Échec du déploiement'; exit 1; }

# Capture de l’URL
URL=$(vercel --prod --yes 2>/dev/null | grep -Eo 'https://[a-zA-Z0-9.-]+\.vercel\.app' | tail -n1)

if [ -n "$URL" ]; then
  echo "✅ Projet déployé à l’URL : $URL"
  echo "$URL" > .vercel-deploy.log
else
  echo "⚠️  URL non détectée automatiquement. Vérifie manuellement dans l’interface Vercel."
fi
