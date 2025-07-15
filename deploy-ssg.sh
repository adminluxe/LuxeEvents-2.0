#!/usr/bin/env bash
set -euo pipefail

# -------------------------------------------------------------------
# CONFIGURATION
# -------------------------------------------------------------------
CI_PROVIDER=${CI_PROVIDER:-vercel}           # "vercel" ou "netlify"
BUILD_DIR=dist                               # dossier de build Vite-SSG
SLACK_WEBHOOK_URL=${SLACK_WEBHOOK_URL:-""}   # URL du webhook Slack (optionnel)
PROJECT_NAME="LuxeEvents Front V2"

# -------------------------------------------------------------------
# Helpers
# -------------------------------------------------------------------
function notify_slack() {
  local status=$1 msg=$2 color=$3
  [[ -z "$SLACK_WEBHOOK_URL" ]] && return
  payload=$(jq -n \
    --arg title "[$PROJECT_NAME] $status" \
    --arg text "$msg" \
    --arg color "$color" \
    '{
       attachments:[{
         color: $color,
         title: $title,
         text: $text
       }]
    }')
  curl -s -X POST -H 'Content-type: application/json' \
       --data "$payload" "$SLACK_WEBHOOK_URL" >/dev/null
}

trap 'notify_slack "❌ ÉCHEC" "Étape : $BASH_COMMAND" "danger"; exit 1' ERR

# -------------------------------------------------------------------
# 1. INSTALLATION DES DÉPENDANCES
# -------------------------------------------------------------------
echo -e "\n🛠️  Installation des dépendances via pnpm"
pnpm install --frozen-lockfile

# Pour autoriser les build-scripts ignorés (ex: puppeteer),
# décommentez la ligne suivante :
# pnpm approve-builds

# -------------------------------------------------------------------
# 2. LINT & FORMAT
# -------------------------------------------------------------------
echo -e "\n📐 Linting & Format"
pnpm run lint
pnpm run format:check

# -------------------------------------------------------------------
# 3. TESTS
# -------------------------------------------------------------------
echo -e "\n✅ Tests unitaires (Jest)"
pnpm run test -- --coverage --passWithNoTests

# -------------------------------------------------------------------
# 4. GÉNÉRATION sitemap & robots.txt
# -------------------------------------------------------------------
echo -e "\n🌐 Génération sitemap.xml & robots.txt"
pnpm run generate:sitemap || echo "⚠️ generate:sitemap échoué"
pnpm run generate:robots  || echo "⚠️ generate:robots échoué"

# -------------------------------------------------------------------
# 5. AUDIT ACCESSIBILITÉ & PERFORMANCE
# -------------------------------------------------------------------
echo -e "\n🔍 Audit Lighthouse CI"
if command -v lhci &>/dev/null; then
  lhci autorun --config=./lighthouserc.js
else
  echo "⚠️ lhci non trouvé — installez @lhci/cli si besoin"
fi

# -------------------------------------------------------------------
# 6. BUILD PRODUCTION
# -------------------------------------------------------------------
echo -e "\n⚙️  Build production (Vite-SSG)"
pnpm run build

# -------------------------------------------------------------------
# 7. DÉPLOIEMENT
# -------------------------------------------------------------------
echo -e "\n🚀 Déploiement sur $CI_PROVIDER"
if [[ "$CI_PROVIDER" == "vercel" ]]; then
  pnpm exec vercel --prod --confirm
elif [[ "$CI_PROVIDER" == "netlify" ]]; then
  pnpm exec netlify deploy --dir=$BUILD_DIR --prod
else
  echo "❌ CI_PROVIDER invalide : $CI_PROVIDER"
  exit 1
fi

notify_slack "✅ Succès" "Front V2 en ligne !" "good"
echo -e "\n🎉 Déploiement terminé — bon travail !\n"
