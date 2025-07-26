#!/bin/bash

NOW=$(date "+%Y%m%d-%H%M")
TAG="v1-luxeevents-final"
BACKUP_DIR="backups"
ARCHIVE_NAME="v1-$NOW.tar.gz"
CSS_FILE="src/components/HeroSection.css"
JSX_FILE="src/components/HeroSection.jsx"
TAILWIND_FILE="tailwind.config.js"

echo "🔧 [LuxeEvents] Patch & sauvegarde de la V1 finale..."

### 1. Nettoyage et recréation HeroSection.css
echo "🧹 Suppression ancienne HeroSection.css corrompue..."
rm -f "$CSS_FILE"

echo "🎨 Recréation propre de HeroSection.css..."
cat <<'CSS' > "$CSS_FILE"
/* HeroSection.css - clean reset */

.hero-container {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  padding: 2rem;
  background-color: #0e0c0c;
  color: #f8e9c8;
  flex-direction: column;
  text-align: center;
}

.hero-title {
  font-size: 3rem;
  font-weight: bold;
  color: #f8e9c8;
  text-shadow: 2px 2px 4px #000;
}

.hero-subtitle {
  font-size: 1.5rem;
  margin-top: 1rem;
  color: #fff8dc;
  text-shadow: 1px 1px 3px #000;
}

.hero-button {
  margin-top: 2rem;
  padding: 1rem 2rem;
  background-color: transparent;
  border: 2px solid #f8e9c8;
  color: #f8e9c8;
  border-radius: 9999px;
  font-weight: 600;
  transition: all 0.3s ease-in-out;
  text-shadow: 1px 1px 2px #000;
  cursor: pointer;
}

.hero-button:hover {
  background-color: #f8e9c8;
  color: #0e0c0c;
  box-shadow: 0 0 12px #f8e9c8;
}
CSS

### 2. Vérifie ou injecte l’import dans HeroSection.jsx
if ! grep -q "import './HeroSection.css'" "$JSX_FILE"; then
  echo "➕ Ajout de l'import './HeroSection.css' dans HeroSection.jsx..."
  sed -i "1s;^;import './HeroSection.css';\n;" "$JSX_FILE"
else
  echo "✅ Import CSS déjà présent."
fi

### 3. Patch tailwind.config.js
if [[ ! -f "$TAILWIND_FILE" ]]; then
  echo "🚧 Fichier tailwind manquant. Abandon..."
  exit 1
fi

echo "🎯 Injection fadeIn et couleurs dans Tailwind..."
if ! grep -q "fadeIn" "$TAILWIND_FILE"; then
  sed -i "/extend: {/a\\
      colors: { gold: '#f8e9c8', ivory: '#fff8dc', dark: '#0e0c0c' },\\
      animation: { fadeIn: 'fadeIn 1.2s ease-in-out forwards' },\\
      keyframes: {\\
        fadeIn: {\\
          '0%': { opacity: '0', transform: 'translateY(20px)' },\\
          '100%': { opacity: '1', transform: 'translateY(0)' }\\
        }\\
      },
" "$TAILWIND_FILE"
else
  echo "✅ fadeIn déjà présent dans Tailwind."
fi

### 4. Vérifie classe fadeIn + text-gold dans HeroSection
if ! grep -q 'className=.*fadeIn' "$JSX_FILE"; then
  sed -i 's/className="/className="fadeIn /' "$JSX_FILE"
  echo "🎉 Class fadeIn ajoutée."
fi

if ! grep -q 'className=.*text-gold' "$JSX_FILE"; then
  sed -i 's/className="/className="text-gold /' "$JSX_FILE"
  echo "🎉 Class text-gold ajoutée."
fi

### 5. Git commit + tag + archive
echo "🧩 Staging & commit Git..."
git add .
git commit -m "🔥 [V1-LuxeEvents] Finalisation patch Hero + Tailwind + fadeIn ($NOW)"
git tag -f "$TAG"

echo "🗃️  Création d’une archive de sauvegarde dans $BACKUP_DIR/$ARCHIVE_NAME..."
mkdir -p "$BACKUP_DIR"
tar --exclude='./node_modules' --exclude='./.git' -czf "$BACKUP_DIR/$ARCHIVE_NAME" .

echo "✅ Sauvegarde complète :"
echo "   • Tag         : $TAG"
echo "   • Archive     : $BACKUP_DIR/$ARCHIVE_NAME"
echo "   • Timestamp   : $NOW"
echo "   • Status      : prêt pour push & déploiement !"
