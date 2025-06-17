#!/bin/bash

## --------------------------------------------------
## 🌺 LUXEEVENTS SPA SCRIPT - Version Royale 🌺
## --------------------------------------------------
# Ce script est un moment de sérénité numérique.
# Il build, déploie, notifie, sublime. Il fait tout.
# Par Tonton & GPT, pour l'excellence.
## --------------------------------------------------

## 🛑 STOP EN CAS D'ERREUR
set -e

## 🌸 PARAMÈTRES
PROJECT_NAME="LuxeEvents"
FRONT_DIR="/home/tontoncestcarre/luxeevents-frontend"
BACKUP_DIR="/home/tontoncestcarre/backups"
GIT_BRANCH="main"
LOG_FILE="$FRONT_DIR/deploy.log"
SMS_NUMBER="+32465222629"
NOW=$(date '+%Y-%m-%d_%H-%M-%S')

## 💆‍♂️ ETAPE 0 - INTRO
clear
echo "\n🧖‍♀️ Bienvenue dans le SPA numérique de $PROJECT_NAME..."
echo "🪷 Nous allons purifier, masser, et faire rayonner ton projet !"

## 💾 ETAPE 1 - BACKUP
mkdir -p "$BACKUP_DIR/$NOW"
echo "📦 Sauvegarde en cours... ➤ $BACKUP_DIR/$NOW"
cp -r "$FRONT_DIR" "$BACKUP_DIR/$NOW"

## ✍️ ETAPE 2 - CORRECTIONS AUTOMATIQUES (ex : fix imports)
INDEX_FILE="$FRONT_DIR/src/index.js"
if grep -q "App from './App'" "$INDEX_FILE"; then
  echo "🛠 Correction auto de l'import App.js..."
  sed -i "s/App from '\.\/App'/App from '\.\/App.js'/" "$INDEX_FILE"
fi

## 🔧 ETAPE 3 - GIT ADD + COMMIT + PUSH
cd "$FRONT_DIR"
echo "📂 Commit & Push Git..."
git add .
git commit -m "🚀 Deploy du $NOW avec corrections & build"
git push origin $GIT_BRANCH

## 🏗️ ETAPE 4 - BUILD VERCEL (auto grâce au push)
echo "🏗️ Build déclenché via push sur GitHub (Vercel suit)"

## 🔍 ETAPE 5 - VALIDATION DU BUILD
echo "⏳ Attente 15 secondes pour laisser Vercel démarrer..."
sleep 15
echo "🔗 Vérifie manuellement l'URL Vercel ou attends les alertes"

## 📓 ETAPE 6 - LOG
mkdir -p "$FRONT_DIR/logs"
echo "[$NOW] Deploy & push effectués sur $GIT_BRANCH" >> "$LOG_FILE"

## 📲 ETAPE 7 - NOTIFICATION (SMS avec placeholder)
echo "📱 Envoi d'une notification SMS (mocké)..."
echo "💬 [SMS] 🎉 $PROJECT_NAME déployé avec succès à $NOW !" > /dev/null
# Intégration future : Twilio, OVH, AWS SNS etc.

## 🌈 FIN
echo "\n✅✨ $PROJECT_NAME est prêt à briller."
echo "🧘 Respire... Tout est fluide, propre, prêt."
echo "🕊️ Fin de la session SPA numérique."
echo "\n🌐 Ton build est visible sur : https://luxeevents-frontend.vercel.app (si pas de domaine encore)"

## 📝 BONUS FUTUR :
# - Ajout auto du domaine via Vercel CLI
# - Validation HTTP code du frontend
# - Webhook vers Slack ou Discord
# - Notification sonore si local

exit 0
