#!/bin/bash

echo "🚀 Build & Déploiement Vercel – VERSION FINALE"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="logs/build-final-$TIMESTAMP.log"
mkdir -p logs

# Rebuild + log
echo "🛠 Rebuild propre en cours..."
npm run build | tee "$LOG_FILE"

# Push en prod forcé
echo "📡 Déploiement Vercel..."
vercel --prod --force --yes | tee -a "$LOG_FILE"

echo "✅ Terminé – Build log sauvegardé dans : $LOG_FILE"
