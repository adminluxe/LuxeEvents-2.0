#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# —— CONFIGURATION ——
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

SRC_DIR="$HOME/luxeevents-frontend-src/luxeevents-frontend"
BUILD_DIR="$SRC_DIR/build"
DEPLOY_DIR="/var/www/luxeevents-frontend"
LOGFILE="$HOME/deploy/logs/deploy_frontend.log"

# —— LOG FUNCTION ——
mkdir -p "$(dirname "$LOGFILE")"
log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"; }

log "=== Début déploiement frontend ==="

# 1) Vérifier et build
if [ ! -d "$SRC_DIR" ]; then
  log "❌ Répertoire source introuvable : $SRC_DIR"
  exit 1
fi
cd "$SRC_DIR"
log "→ npm ci"
npm ci >> "$LOGFILE" 2>&1
log "→ npm run build"
npm run build >> "$LOGFILE" 2>&1

# 2) Vérifier le build
if [ ! -d "$BUILD_DIR" ]; then
  log "❌ Build introuvable : dossier 'build/' manquant."
  exit 2
fi
log "✅ Build OK"

# 3) Déployer
log "→ Synchronisation vers $DEPLOY_DIR"
sudo mkdir -p "$DEPLOY_DIR"
sudo rsync -a --delete "$BUILD_DIR/" "$DEPLOY_DIR/" >> "$LOGFILE" 2>&1
sudo chown -R www-data:www-data "$DEPLOY_DIR"

# 4) Reload NGINX
log "→ Reload NGINX"
sudo systemctl reload nginx

log "=== Fin déploiement frontend ==="
