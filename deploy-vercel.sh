#!/bin/bash
echo "🚀 Déploiement Vercel en cours pour LuxeEvents…"

# 1. Check que le build est OK
echo "🔎 Vérification du build local (vite build)…"
pnpm run build || { echo "❌ Build échoué. Corrige les erreurs avant de déployer." ; exit 1; }

# 2. Déploiement production
echo "🌍 Déploiement vers Vercel (en mode --prod)…"
vercel --prod --confirm > vercel-deploy.log

# 3. Extraction de l’URL déployée
URL=$(grep -Eo 'https://[a-zA-Z0-9.-]+\.vercel\.app' vercel-deploy.log | tail -1)

# 4. Affichage final
if [ -n "$URL" ]; then
  echo ""
  echo "✅ Déploiement réussi !"
  echo "🌐 Ton site est en ligne ici : $URL"
  echo ""
else
  echo "⚠️ Déploiement effectué, mais l’URL n’a pas pu être détectée."
  echo "   Vérifie le fichier log : cat vercel-deploy.log"
fi

exit 0
