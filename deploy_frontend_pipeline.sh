#!/bin/bash

# ===================================
# 🚀 LuxeEvents - FRONTEND Deploy Pipeline
# Auteur : TontonCestCarré 🟣
# Date : $(date)
# ===================================

set -e  # Arrête le script en cas d'erreur
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="deploy_frontend_$NOW.log"

echo "📦 [1/6] Sauvegarde du projet frontend en cours..."
tar -czf ~/luxeevents-frontend-backup-$NOW.tar.gz . >> $LOG_FILE 2>&1
echo "✅ Sauvegarde créée : luxeevents-frontend-backup-$NOW.tar.gz"

echo "🔧 [2/6] Build de l'app React (vite)..."
npm install >> $LOG_FILE 2>&1
npm run build >> $LOG_FILE 2>&1
echo "✅ Build terminé avec succès"

echo "⬆️ [3/6] Push Git vers GitHub..."
git add . >> $LOG_FILE 2>&1
git commit -m "🚀 Auto-deploy $(date)" >> $LOG_FILE 2>&1 || echo "ℹ️ Rien à commit"
git push origin main >> $LOG_FILE 2>&1
echo "✅ Push effectué"

echo "🌐 [4/6] Déploiement Vercel..."
if [ -z "$VERCEL_TOKEN" ]; then
  echo "❌ VERCEL_TOKEN non défini. Exporte-le avant d'exécuter ce script."
  exit 1
fi
vercel --prod --token "$VERCEL_TOKEN" >> $LOG_FILE 2>&1
echo "✅ Déploiement Vercel déclenché"

echo "📨 [5/6] Notification SMS (Twilio)..."
if [ -n "$TWILIO_ACCOUNT_SID" ] && [ -n "$TWILIO_AUTH_TOKEN" ] && [ -n "$TWILIO_FROM" ] && [ -n "$TWILIO_TO" ]; then
  MESSAGE="✨ LuxeEvents frontend déployé avec succès le $NOW ✨"
  curl -X POST "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/Messages.json" \
    --data-urlencode "Body=$MESSAGE" \
    --data-urlencode "From=$TWILIO_FROM" \
    --data-urlencode "To=$TWILIO_TO" \
    -u "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN" >> $LOG_FILE 2>&1
  echo "✅ SMS envoyé à $TWILIO_TO"
else
  echo "⚠️ Paramètres Twilio manquants, SMS non envoyé"
fi

echo "🎉 [6/6] Déploiement terminé avec succès !"
echo "🗂️ Log du déploiement : $LOG_FILE"
