#!/bin/bash
set -e

ROOT="$(pwd)"
HERO_DIR="$ROOT/public/images/hero"
BACKUP_DIR="$ROOT/_backup_hero_$(date +%Y%m%d-%H%M%S)"

echo "🔒 Backup images hero..."
mkdir -p "$BACKUP_DIR"
cp -a "$HERO_DIR" "$BACKUP_DIR/"

echo "📂 Préparation dossier hero..."
mkdir -p "$HERO_DIR"

echo "⬇️ Téléchargement image premium..."
curl -L \
"https://images.unsplash.com/photo-1515165562835-c1ae3b7f6f90?auto=format&fit=crop&w=2400&q=85" \
-o "$HERO_DIR/hero-premium.webp"

echo "🔁 Normalisation nom..."
mv -f "$HERO_DIR/hero-premium.webp" "$HERO_DIR/hero-bg.webp"

echo "✅ Image hero premium installée : $HERO_DIR/hero-bg.webp"
echo "📦 Backup : $BACKUP_DIR"
