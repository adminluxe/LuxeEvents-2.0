#!/bin/bash

# === check-v3-integrity.sh ===
# Vérifie la présence des composants critiques V3 + push si tout est ok
# Tonton style : rigoureux, millimétré, efficace.

set -e

## Composants attendus dans V3
REQUIRED_COMPONENTS=(
  "src/components/IntroAnimationLottie.jsx"
  "src/components/HeroSection.jsx"
  "src/components/SwiperStory.jsx"
  "src/components/TimelineSection.jsx"
)

## Vérification 1 : chaque fichier existe sur le disque
for file in "${REQUIRED_COMPONENTS[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Manquant : $file"
    exit 1
  else
    echo "✅ Présent : $file"
  fi
done

## Vérification 2 : chaque fichier est tracké par git
UNTRACKED=()
for file in "${REQUIRED_COMPONENTS[@]}"; do
  if ! git ls-files --error-unmatch "$file" > /dev/null 2>&1; then
    UNTRACKED+=("$file")
  fi
done

if [ ${#UNTRACKED[@]} -ne 0 ]; then
  echo "\n🚨 Fichiers non trackés par git :"
  for f in "${UNTRACKED[@]}"; do
    echo "→ $f"
  done
  echo "\n📌 Ajout en staging..."
  git add "${UNTRACKED[@]}"

  echo "📦 Commit en cours..."
  git commit -m "✨ Auto-push: composants V3 essentiels ajoutés (Lottie, Hero, Swiper, Timeline)"

  echo "🚀 Push vers origin/main..."
  git push origin main
else
  echo "\n✅ Tous les composants sont déjà suivis par git."
fi

## Build & déploiement final (si tout est ok)
echo "\n🛠️ Build vite..."
pnpm install
pnpm run build

echo "\n🚀 Déploiement Vercel avec --force..."
vercel --prod --yes --force

echo "\n🎉 Tout est en ligne. Vérifie ton domaine avec : https://luxeevents.me"
