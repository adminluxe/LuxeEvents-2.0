#!/bin/bash

NOW=$(date "+%Y%m%d-%H%M")
TAG="v1-luxeevents-final"
BACKUP_DIR="backups"
ARCHIVE_NAME="v1-$NOW.tar.gz"

echo "📦 [LuxeEvents] Sauvegarde finale de la V1..."

# 1. Git commit & tag
echo "🔐 Staging tous les fichiers modifiés et nouveaux..."
git add .

echo "📝 Commit en cours..."
git commit -m "🔥 [V1-LuxeEvents] Version finale stable - patch luxe + fadeIn + styles Hero ($NOW)"

echo "🏷  Création du tag Git : $TAG"
git tag -f "$TAG"

# 2. Sauvegarde archive locale
mkdir -p "$BACKUP_DIR"
echo "🗄️  Création de l’archive $BACKUP_DIR/$ARCHIVE_NAME..."
tar --exclude='./node_modules' --exclude='./.git' -czf "$BACKUP_DIR/$ARCHIVE_NAME" .

echo "✅ V1 sauvegardée et figée :"
echo "   • Commit & Tag Git      : $TAG"
echo "   • Archive locale        : $BACKUP_DIR/$ARCHIVE_NAME"
echo "   • Date de snapshot      : $NOW"
