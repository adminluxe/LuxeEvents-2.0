#!/bin/bash

echo "=========================================="
echo "🚀 DÉPLOIEMENT FRONTEND - luxeEvents.me 🚀"
echo "=========================================="

# 1. Sauvegarde du projet frontend (désactivée en debug pour éviter les erreurs)
echo "📦 [1/6] Sauvegarde temporairement désactivée (debug mode)"
# BACKUP_NAME="luxeevents-frontend-backup-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
# tar --exclude='node_modules' --exclude='build' -czf "$BACKUP_NAME" . || { echo "❌ Erreur lors de la création de la sauvegarde."; exit 1; }
# echo "✅ Sauvegarde créée : $BACKUP_NAME"

# 2. Build de l'app React
echo "🔧 [2/6] Build de l'app React (vite)..."
npm run build || { echo "❌ Build échoué"; exit 1; }
echo "✅ Build terminé avec succès"

# 3. Push Git vers GitHub
echo "⬆ [3/6] Push Git vers GitHub..."
git add .
git commit -m "Déploiement automatisé $(date '+%Y-%m-%d %H:%M:%S')" || echo "⚠️ Aucun changement à committer"
git push origin main || { echo "❌ Push Git échoué"; exit 1; }
echo "✅ Push effectué"

# 4. Déploiement Vercel
echo "🌐 [4/6] Déploiement Vercel..."
if [ -z "$VERCEL_TOKEN" ]; then
  echo "❌ VERCEL_TOKEN non défini. Exporte-le avant d'exécuter ce script."
  exit 1
fi
vercel deploy --prod --token "$VERCEL_TOKEN" || { echo "❌ Déploiement Vercel échoué"; exit 1; }
echo "✅ Déploiement terminé"

# 5. Notification SMS via Twilio
echo "📲 [5/6] Envoi de notification SMS..."
if [ -z "$TWILIO_ACCOUNT_SID" ] || [ -z "$TWILIO_AUTH_TOKEN" ] || [ -z "$TWILIO_FROM" ] || [ -z "$TWILIO_TO" ]; then
  echo "⚠️ Variables Twilio manquantes, notification SMS annulée."
else
  curl -s -X POST https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/Messages.json \
  --data-urlencode "To=$TWILIO_TO" \
  --data-urlencode "From=$TWILIO_FROM" \
  --data-urlencode "Body=🚀 Déploiement frontend luxeevents.me réussi le $(date '+%Y-%m-%d %H:%M:%S')" \
  -u $TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN
  echo "✅ SMS envoyé"
fi

echo "🎉 Déploiement complet terminé !"
