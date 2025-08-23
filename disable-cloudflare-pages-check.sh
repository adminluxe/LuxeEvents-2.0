#!/usr/bin/env bash
set -euo pipefail

OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"
BRANCH="${BRANCH:-main}"

# Nécessite 'gh' connecté avec droits admin sur le repo
TMP="$(mktemp)"; trap 'rm -f "$TMP" "$TMP.filtered"' EXIT

# 1) Récupère la config de protection actuelle
gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/branches/$BRANCH/protection" > "$TMP"

# 2) Filtre les checks/contexts qui matchent Cloudflare/Pages (insensible à la casse)
CONTEXTS=$(jq -c '[.required_status_checks.contexts[]? | select(test("cloudflare|pages";"i")|not)]' "$TMP")
CHECKS=$(jq -c '[.required_status_checks.checks[]?   | select(.context | test("cloudflare|pages";"i")|not)]' "$TMP")

# 3) Réécrit uniquement la partie required_status_checks, on garde tout le reste
jq --argjson contexts "$CONTEXTS" \
   --argjson checks   "$CHECKS"   '
   .required_status_checks.contexts = $contexts
 | .required_status_checks.checks   = $checks
 ' "$TMP" > "$TMP.filtered"

# 4) Renvoie la protection complète (inchangée sauf CF Pages retiré)
gh api -X PUT -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/branches/$BRANCH/protection" \
  --input "$TMP.filtered" >/dev/null

echo "✓ Cloudflare Pages retiré des checks requis sur $BRANCH."
