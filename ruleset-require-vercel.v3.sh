#!/usr/bin/env bash
set -euo pipefail

OWNER="${GITHUB_USERNAME:-adminluxe}"
REPO="LuxeEvents-2.0"

# Crée un ruleset (ou remplace s’il existe déjà) qui exige uniquement le check "Vercel" sur main
# NB: conditions.ref_name.include accepte "refs/heads/main" ou "~DEFAULT_BRANCH".
#     On met la forme explicite pour éviter toute ambiguïté.
PAYLOAD="$(cat <<'JSON'
{
  "name": "Require Vercel (main)",
  "target": "branch",
  "enforcement": "active",
  "conditions": {
    "ref_name": {
      "include": ["refs/heads/main"],
      "exclude": []
    }
  },
  "rules": [
    {
      "type": "required_status_checks",
      "parameters": {
        "required_checks": [
          { "context": "Vercel" }
        ],
        "do_not_enforce_on_create": true,
        "strict_required_status_checks_policy": false
      }
    }
  ]
}
JSON
)"

# Si un ruleset de même nom existe, on le met à jour, sinon on le crée
EXIST_ID="$(gh api \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/rulesets --jq '
    map(select(.name=="Require Vercel (main)")) | (.[0].id // empty)'
)"

if [[ -n "${EXIST_ID:-}" ]]; then
  echo "• Update du ruleset #$EXIST_ID…"
  gh api -X PUT \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /repos/$OWNER/$REPO/rulesets/$EXIST_ID \
    --input <(printf '%s' "$PAYLOAD") >/dev/null
else
  echo "• Création du ruleset…"
  gh api -X POST \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /repos/$OWNER/$REPO/rulesets \
    --input <(printf '%s' "$PAYLOAD") >/dev/null
fi

echo "✓ Ruleset 'Require Vercel (main)' actif."
