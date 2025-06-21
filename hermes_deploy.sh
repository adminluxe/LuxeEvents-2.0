#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'hermes_deploy'. Description à compléter.
#!/usr/bin/env bash

# --------------------------------------------------
# 🕊️ Grimoire Hermès — Script de Déploiement Ultime
# --------------------------------------------------
# Un déploiement sans stress, régulier, fiable.
# Par Tonton & GPT, pour l'excellence numérique.
# --------------------------------------------------

set -euo pipefail
IFS=$'\n\t'

#####################################
# Configuration
#####################################
PROJECT="LuxeEvents"
FRONT_DIR="/home/tontoncestcarre/luxeevents-frontend"
BACK_DIR="/home/tontoncestcarre/luxeevents-backend"
BACKUP_ROOT="/home/tontoncestcarre/backups"
GIT_BRANCH="main"
LOGFILE="${FRONT_DIR}/hermes_deploy.log"
NOW=$(date '+%Y-%m-%d_%H-%M-%S')

#####################################
# Fonctions
#####################################
log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"; }
exit_on_error() { log "❌ Erreur survenue. Abandon."; exit 1; }
trap exit_on_error ERR

#####################################
# Début du chapitre Hermès
#####################################
log "=== Hermès Deploy Start: $NOW ==="

#####################################
# 1) Sauvegarde Complette
#####################################
BACKUP_PATH="$BACKUP_ROOT/${NOW}"
mkdir -p "$BACKUP_PATH"
log "[1] Sauvegarde Frontend → $BACKUP_PATH/frontend"
cp -r "$FRONT_DIR" "$BACKUP_PATH/frontend"
log "[1] Sauvegarde Backend  → $BACKUP_PATH/backend"
cp -r "$BACK_DIR" "$BACKUP_PATH/backend"

#####################################
# 2) Tests Automatisés
log "[2] Vérification de la présence des scripts npm pour lint & unit tests"
cd "$FRONT_DIR"
if npm run | grep -q 'lint'; then
  log "[2] Lancement du lint"
  npm run lint
else
  log "[2] Script 'lint' non trouvé, skipped"
fi
if npm run | grep -q 'test'; then
  log "[2] Lancement des tests unitaires"
  npm test -- --watchAll=false
else
  log "[2] Script 'test' non trouvé, skipped"
fi

# 3) Build & Compilation
#####################################
log "[3] Build Frontend"
cd "$FRONT_DIR"
npm install
npm run build || exit_on_error

log "[3] Build Backend (si applicable)"
cd "$BACK_DIR"
npm install
npm run build || log "⚠️ Pas de build backend nécessaire"

#####################################
# 4) Git Commit & Push
#####################################
log "[4] Commit & push Git"
cd "$FRONT_DIR"
git add -A
if git diff --cached --quiet; then
  log "[4] Aucun changement à pusher"
else
  git commit -m "⚙️ Hermès Deploy $NOW"
  git push origin $GIT_BRANCH
fi

#####################################
# 5) Déploiement sur Vercel
#####################################
log "[5] Déploiement Vercel via GitHub Actions"
# (CI/CD déclenché par push)

#####################################
# 6) Nettoyage post-build
#####################################
log "[6] Nettoyage node_modules et cache"
rm -rf "$FRONT_DIR/node_modules" "$BACK_DIR/node_modules"
rm -rf "$FRONT_DIR/.cache" "$BACK_DIR/.cache"

#####################################
# 7) Notification Finale
#####################################
log "[7] Notification Slack (via webhook)"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXX/YYY/ZZZ"
payload="{\"text\":\"🚀 $PROJECT déployé avec succès à $NOW !\"}"
curl -X POST -H 'Content-type: application/json' --data "$payload" "$SLACK_WEBHOOK_URL"

#####################################
# Fin du déploiement
#####################################
log "=== Hermès Deploy End: $(date '+%Y-%m-%d_%H:%M:%S') ==="

exit 0
