#!/bin/bash

# === 📅 Timestamp pour backup ===
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="luxeevents-frontend-backup-$NOW.tar.gz"

echo "📦 [1/6] Sauvegarde du projet frontend en cours..."
tar -czf "$BACKUP_FILE" . --exclude=node_modules --exclude=dist
echo "✅ Sauvegarde créée : $BACKUP_FILE"

echo "🔧 [2/6] Build de l'app React (vite)..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Échec du build. Déploiement annulé."
    exit 1
fi
echo "✅ Build terminé avec succès"

echo "⬆ [3/6] Push Git vers GitHub..."
git add .
git commit -m "🚀 Auto-deploy $NOW"
git push origin main
echo "✅ Push effectué"

echo "🌐 [4/6] Déploiement Vercel..."
if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ VERCEL_TOKEN non défini. Exporte-le avant d'exécuter ce script."
    exit 1
fi

# Remplace ceci par l’ID réel de ton projet (copié depuis Vercel)
PROJECT_ID="prj_2t3z8dnrD"

RESPONSE=$(curl -s -X POST "https://api.vercel.com/v1/integrations/deploy/$PROJECT_ID" \
  -H "Authorization: Bearer $VERCEL_TOKEN" \
  -H "Content-Type: application/json")

if echo "$RESPONSE" | grep -q '"name":"deployment-created"'; then
    echo "✅ Déploiement Vercel déclenché avec succès !"
else
    echo "❌ Échec du déclenchement Vercel."
    echo "🧾 Réponse reçue :"
    echo "$RESPONSE"
    MSG="❌ Échec du déploiement Vercel à $NOW."
    send_sms=true
    exit_code=1
fi

echo "📂 [5/6] Nettoyage optionnel (temp files ou autres)..."
# Ici tu peux ajouter un `rm -rf dist/` si tu veux nettoyer après build
echo "✅ Nettoyage terminé (aucune action spécifique)"

echo "📱 [6/6] Envoi de la notification SMS via Twilio..."

if [ -z "$MSG" ]; then
    MSG="✅ Déploiement frontend luxeevents.me terminé avec succès à $NOW"
fi

if [ -n "$TWILIO_ACCOUNT_SID" ] && [ -n "$TWILIO_AUTH_TOKEN" ] && [ -n "$TWILIO_FROM" ] && [ -n "$TWILIO_TO" ]; then
    curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/Messages.json" \
    --data-urlencode "Body=$MSG" \
    --data-urlencode "From=$TWILIO_FROM" \
    --data-urlencode "To=$TWILIO_TO" \
    -u "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN" > /dev/null
    echo "✅ Notification envoyée à $TWILIO_TO"
else
    echo "⚠️ Variables Twilio incomplètes, SMS non envoyé"
fi

exit ${exit_code:-0}
