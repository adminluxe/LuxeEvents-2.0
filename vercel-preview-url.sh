#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

: "${VERCEL_TOKEN:?VERCEL_TOKEN manquant (exporte-le dans ton shell).}"

OWNER="${GITHUB_USERNAME:-adminluxe}"
REPO="LuxeEvents-2.0"

# Paramètres (modifiable à l'exécution)
BRANCH="${BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"
SHA="${SHA:-$(git rev-parse HEAD)}"
VERCEL_PROJECT="${VERCEL_PROJECT:-luxeevents}"      # ← nom du projet Vercel (vu dans tes URLs)
TEAM_ID="${VERCEL_TEAM_ID:-}"                       # optionnel: team_****** (sinon requête sans team)
TEAM_QS="$([ -n "$TEAM_ID" ] && printf '&teamId=%s' "$TEAM_ID" || printf '')"

api() {  # usage: api <pathWithQuery>
  curl -fsSL -H "Authorization: Bearer $VERCEL_TOKEN" "https://api.vercel.com$1"
}

open_url() {
  local url="$1"
  echo "✓ Preview URL: $url"
  if command -v xdg-open >/dev/null 2>&1; then xdg-open "$url" >/dev/null 2>&1 || true; fi
  if command -v open >/dev/null 2>&1; then open "$url" >/dev/null 2>&1 || true; fi
}

echo "== Vercel preview • project=$VERCEL_PROJECT • branch=$BRANCH =="
# 1) Cherche un déploiement READY lié exactement au commit (meta-githubCommitSha)
URL="$(api "/v6/deployments?app=${VERCEL_PROJECT}&meta-githubCommitSha=${SHA}&limit=5${TEAM_QS}" \
  | jq -r '[.deployments[]? | select(.readyState=="READY")][0].url // empty' || true)"

# 2) Sinon, cherches par branche (meta-githubCommitRef)
if [ -z "$URL" ]; then
  URL="$(api "/v6/deployments?app=${VERCEL_PROJECT}&meta-githubCommitRef=${BRANCH}&limit=20${TEAM_QS}" \
    | jq -r '[.deployments[]? | select(.readyState=="READY")][0].url // empty' || true)"
fi

# 3) Sinon, cherches par 'target=preview' (les plus récents d'abord)
if [ -z "$URL" ]; then
  URL="$(api "/v6/deployments?app=${VERCEL_PROJECT}&target=preview&limit=20${TEAM_QS}" \
    | jq -r '[.deployments[]? 
               | select(.readyState=="READY") 
               | select((.meta.githubCommitRef // .meta.GITHUB_COMMIT_REF // "") == "'$BRANCH'")]
             | (.[0].url // empty)' || true)"
fi

# 4) Fallback: tente depuis le statut GitHub "Vercel" (target_url) et remonte l'URL d'alias si possible
if [ -z "$URL" ]; then
  if command -v gh >/dev/null 2>&1; then
    PR_NUM="$(gh pr list --head "$BRANCH" --json number -q '.[0].number' 2>/dev/null || true)"
    if [ -n "$PR_NUM" ]; then
      VC_PAGE="$(gh api "/repos/$OWNER/$REPO/commits/$SHA/status" -H "Accept: application/vnd.github+json" \
        --jq '.statuses[] | select(.context=="Vercel") | .target_url' 2>/dev/null || true)"
      if [ -n "$VC_PAGE" ]; then
        echo "• Checks page: $VC_PAGE"
        # parfois, l'alias est inclus comme '…-vercel.app' sur la page Vercel (à ouvrir à la main)
      fi
    fi
  fi
fi

if [ -z "$URL" ]; then
  echo "✖ Impossible de trouver l'URL de preview via l'API. 
Tips:
  - Vérifie que VERCEL_PROJECT est correct (actuel: '$VERCEL_PROJECT').
  - Si le projet est dans une équipe, exporte VERCEL_TEAM_ID (team_xxxxxx).
  - Sinon ouvre la page de checks Vercel ci-dessus et clique le lien 'Visit'." >&2
  exit 1
fi

# L'API renvoie un host nu comme "luxeevents-abc123-adminluxes-projects.vercel.app"
# On préfixe en https:// si besoin.
case "$URL" in
  http*) open_url "$URL" ;;
  *)     open_url "https://$URL" ;;
esac
