#!/bin/bash

# Date et heure actuelles pour le nom de la sauvegarde
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="luxeevents-frontend-backup-$NOW.tar.gz"

echo "=========================================="
echo "🚀 DÉPLOIEMENT FRONTEND - luxeEvents.me 🚀"
echo "=========================================="

# ==========================================
# 1. Sauvegarde du projet frontend
# ==========================================

# echo "📦 [1/6] Sauvegarde du projet frontend en cours..."
# tar --exclude='node_modules' --exclude='dist' -czf "$BACKUP_FILE" .
# if [ $? -ne 0 ]; then
#     echo "❌ Erreur lors de la création de la sauvegarde."
#     exit 1
# fi
# echo "✅ Sauvegarde créée : $BACKUP_FILE"

echo "📦 [1/6] Sauvegarde temporairement désactivée (debug mode)"

# ==========================================
# 2. Build de l'application React
# ==========================================
echo "🔧 [2/6] Build de l'app React (vite)..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Build échoué."
    exit 1
fi
echo "✅ Build terminé avec succès"

# ==========================================
# 3. Push Git vers GitHub
# ==========================================
echo "⬆ [3/6] Push Git vers GitHub..."
git add .
git commit -m "🚀 Auto-deploy: build & push @ $NOW"
git push origin main
if [ $? -ne 0 ]; then
    echo "❌ Push Git échoué."
    exit 1
fi
echo "✅ Push effectué"

# ==========================================
# 4. Trigger déploiement Vercel via API
# ==========================================
echo "🌐 [4/6] Déploiement Vercel..."
if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ VERCEL_TOKEN non défini. Exporte-le avant d'exécuter ce script."
    exit 1
fi

curl -X POST "https://api.vercel.com/v1/integrations/deploy/prj_3yabPxghw9zKzNoXk1x0y9tUFS1N/tB6YMbFa6Y" \
  -H "Authorization: Bearer $VERCEL_TOKEN"

if [ $? -ne 0 ]; then
    echo "❌ Erreur lors du trigger Vercel"
    exit 1
fi
echo "✅ Déploiement Vercel déclenché"

# ==========================================
# 5. Notification SMS via Twilio
# ==========================================
echo "📲 [5/6] Envoi de la notification SMS..."
if [ -z "$TWILIO_ACCOUNT_SID" ] || [ -z "$TWILIO_AUTH_TOKEN" ] || [ -z "$TWILIO_FROM" ] || [ -z "$TWILIO_TO" ]; then
    echo "⚠️  Infos Twilio incomplètes, SMS non envoyé"
else
    MESSAGE="✨ luxeEvents.me frontend déployé avec succès à $NOW ✨"
    curl -X POST "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/Messages.json" \
        --data-urlencode "Body=$MESSAGE" \
        --data-urlencode "From=$TWILIO_FROM" \
        --data-urlencode "To=$TWILIO_TO" \
        -u "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN"
    echo "✅ SMS envoyé à $TWILIO_TO"
fi

# ==========================================
# 6. Fin du script
# ==========================================
echo "🎉 [6/6] Déploiement terminé. Mission accomplie, Tonton."
