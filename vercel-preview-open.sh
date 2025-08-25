#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

OWNER="${GITHUB_USERNAME:-adminluxe}"
REPO="LuxeEvents-2.0"
BASE="${BASE:-main}"
BR="${BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"
OPEN="${OPEN:-1}"   # 1 = tente d'ouvrir dans le navigateur

echo "== Vercel Preview • ${OWNER}/${REPO} • branch: ${BR} =="

# 1) Récupère / crée la PR
PR="$(gh pr list --head "$BR" --json number -q '.[0].number' 2>/dev/null || true)"
if [ -z "$PR" ]; then
  echo "• Aucune PR pour '$BR' → création…"
  gh pr create --base "$BASE" --head "$BR" \
    --title "chore(wip): $BR" \
    --body "PR auto pour prévisualisation Vercel." >/dev/null
  PR="$(gh pr list --head "$BR" --json number -q '.[0].number')"
fi
PR_URL="$(gh pr view "$PR" --json url -q .url)"
echo "• PR #$PR → $PR_URL"

# 2) Attend que Vercel soit vert (max ~90s)
SHA="$(gh pr view "$PR" --json headRefOid -q .headRefOid)"
echo "• Head SHA: $SHA"
for i in $(seq 1 45); do
  OK="$(gh api "/repos/$OWNER/$REPO/commits/$SHA/check-runs" \
      -H "Accept: application/vnd.github+json" \
      --jq '[.check_runs[]? | select((.app.slug=="vercel") and (.status=="completed") and (.conclusion=="success"))] | length')"
  [ "$OK" -gt 0 ] && break
  sleep 2
done

# 3) Tente via Deployments → environment_url
echo "• Recherche des deployments GitHub…"
DEP_ID="$(gh api "/repos/$OWNER/$REPO/deployments?ref=$BR&per_page=10" \
   -H "Accept: application/vnd.github+json" \
   --jq 'map(select(.environment | test("preview";"i")))[0].id' 2>/dev/null || true)"
if [ -n "${DEP_ID:-}" ] && [ "$DEP_ID" != "null" ]; then
  PREVIEW_URL="$(gh api "/repos/$OWNER/$REPO/deployments/$DEP_ID/statuses" \
     -H "Accept: application/vnd.github+json" \
     --jq 'map(select(.state=="success")) | (.[0].environment_url // .[0].target_url // empty)' 2>/dev/null || true)"
fi

# 4) Fallback: commentaire vercel[bot] dans la PR
if [ -z "${PREVIEW_URL:-}" ]; then
  echo "• Fallback: scan des commentaires de PR…"
  PREVIEW_URL="$(gh api "/repos/$OWNER/$REPO/issues/$PR/comments?per_page=100" \
    -H "Accept: application/vnd.github+json" \
    --jq '
      [ .[] 
        | select((.user.login=="vercel[bot]") or (.body|test("vercel|preview";"i")))
        | (.body | capture("(?<url>https://[a-zA-Z0-9._/-]+)";"")? // empty)
      ][0].url // empty' 2>/dev/null || true)"
fi

# 5) Si toujours rien, affiche au moins la page de checks Vercel
if [ -z "${PREVIEW_URL:-}" ]; then
  echo "• Pas de preview directe trouvée. Lien Vercel (checks) via statut :"
  VC_TARGET="$(gh api "/repos/$OWNER/$REPO/commits/$SHA/status" \
    -H "Accept: application/vnd.github+json" \
    --jq '.statuses[] | select(.context=="Vercel") | .target_url' 2>/dev/null || true)"
  echo "  - Checks: ${VC_TARGET:-<non dispo>}"
  echo "  - PR: $PR_URL"
  exit 0
fi

echo "✓ Preview URL: $PREVIEW_URL"
if [ "$OPEN" = "1" ]; then
  if command -v xdg-open >/dev/null 2>&1; then xdg-open "$PREVIEW_URL" >/dev/null 2>&1 || true; fi
  if command -v open >/dev/null 2>&1; then open "$PREVIEW_URL" >/dev/null 2>&1 || true; fi
fi
