#!/bin/bash

# === fix-i18n-corruption.sh ===
# Répare les erreurs MIME/JSX/Vite liées à i18n.js, CircularMenu, StorySwiper, etc.
# By Tonton Certified™

set -e

RESET="\033[0m"
OK="\033[1;32m✔\033[0m"
INFO="\033[1;34m✨\033[0m"

## 1. Purge du fichier corrompu i18n.js
printf "$INFO Recréation de src/i18n.js propre...\n"
cat > src/i18n.js <<'EOF'
import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import fr from "./locales/fr/translation.json";
import en from "./locales/en/translation.json";

i18n.use(initReactI18next).init({
  resources: {
    fr: { translation: fr },
    en: { translation: en },
  },
  lng: "fr",
  fallbackLng: "fr",
  interpolation: { escapeValue: false },
});

export default i18n;
EOF
printf "$OK i18n.js réécrit avec succès\n"

## 2. Correction CircularMenu.jsx
printf "$INFO Correction JSX multiple return dans CircularMenu.jsx...\n"
sed -i 's/return (/return (<>/' src/components/CircularMenu.jsx
sed -i '$s/);/<\/>);/' src/components/CircularMenu.jsx

## 3. Injection du toggleLanguage + import manquant
sed -i '/useState/a\
  import { useTranslation } from "react-i18next";' src/components/CircularMenu.jsx

sed -i '/const \[open, setOpen\]/a\
  const { i18n } = useTranslation();\
  const toggleLanguage = () => i18n.changeLanguage(i18n.language === "fr" ? "en" : "fr");' src/components/CircularMenu.jsx

printf "$OK CircularMenu corrigé avec toggle langue\n"

## 4. Fix template string sur fichiers JS mal lus
printf "$INFO Correction des template strings dans StorySwiper.jsx et FadeUpWrapper.jsx...\n"
sed -i 's/className={`snap-start ${className}`}/className={"snap-start " + className}/' src/components/FadeUpWrapper.jsx
sed -i 's/=> `\/images\/story\/story-${i + 1}.webp`/=> "/images/story/story-" + (i + 1) + ".webp"/' src/components/StorySwiper.jsx

## 5. Clean .vite & dist
printf "$INFO Suppression du cache Vite...\n"
rm -rf node_modules/.vite dist

printf "$OK Vite reseté\n"

## 6. Redémarrage
printf "$INFO Redémarre ton projet avec :\n\n  npm run dev\n\nEt recharge avec Ctrl+Maj+R si besoin.\n"
