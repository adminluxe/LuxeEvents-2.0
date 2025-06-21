#!/bin/bash

# ===============================
# 🌟 luxeEvents.me - Fusion Frontend Script 🌟
# Structure + Déploiement + Harmonie parfaite
# ===============================

set -e
START_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$HOME/luxeevents-frontend/deploy_frontend_$START_TIME.log"

# --- 🎵 Intro ---
echo -e "[🌈] Lancement de la fusion frontend de luxeEvents.me...\n" | tee -a "$LOG_FILE"

# --- 🎯 Variables ---
FRONT_DIR="$HOME/luxeevents-frontend"
BACK_URL=$(vercel --token $VERCEL_TOKEN --scope adminluxes-projects --prod --cwd "$HOME/luxeevents-backend" | grep -o 'https://[^"]*.vercel.app' | head -n 1)

# --- 📁 Vérification des dossiers ---
if [ ! -d "$FRONT_DIR" ]; then
  echo "❌ Dossier frontend introuvable : $FRONT_DIR" | tee -a "$LOG_FILE"
  exit 1
fi

# --- 🔧 Mise à jour VITE_BACKEND_URL ---
ENV_FILE="$FRONT_DIR/.env"
echo "VITE_BACKEND_URL=$BACK_URL" > "$ENV_FILE"
echo "[🔁] Fichier .env mis à jour avec l'URL du backend : $BACK_URL" | tee -a "$LOG_FILE"

# --- 🧼 Nettoyage & Install ---
echo "[🧹] Nettoyage & installation des dépendances..." | tee -a "$LOG_FILE"
cd "$FRONT_DIR"
rmdir -p build 2>/dev/null || true
rm -rf dist node_modules
npm install >> "$LOG_FILE" 2>&1

# --- 🛠️ Build ---
echo "[🏗️ ] Construction de la symphonie frontend..." | tee -a "$LOG_FILE"
npm run build >> "$LOG_FILE" 2>&1

# --- 🚀 Déploiement ---
echo "[🚀] Déploiement Vercel frontend..." | tee -a "$LOG_FILE"
FRONT_URL=$(vercel --token $VERCEL_TOKEN --scope adminluxes-projects --prod --confirm --cwd "$FRONT_DIR" | grep -o 'https://[^"]*.vercel.app' | head -n 1)
echo "[✅] Frontend déployé avec succès sur : $FRONT_URL" | tee -a "$LOG_FILE"

# --- 📄 Finalisation ---
echo "\n🎉 Déploiement complet : frontend en ligne et connecté au backend.\n" | tee -a "$LOG_FILE"
echo "🌐 FRONTEND : $FRONT_URL" | tee -a "$LOG_FILE"
echo "🧠 BACKEND  : $BACK_URL" | tee -a "$LOG_FILE"
echo "📄 LOG : $LOG_FILE"

exit 0
