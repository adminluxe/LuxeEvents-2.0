#!/usr/bin/env bash
set -euo pipefail
OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"
BRANCH="${BRANCH:-main}"
RULESET_NAME="${RULESET_NAME:-Require Vercel Checks (main)}"

# 1) Existe déjà ?
EXISTING_ID="$(gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/rulesets?per_page=100" \
  | jq -r --arg NAME "$RULESET_NAME" '.[] | select(.name==$NAME) | .id' | head -n1)"

# 2) JSON du ruleset (contexts = "Vercel" uniquement)
BODY="$(jq -n \
  --arg name "$RULESET_NAME" \
  --arg branch "$BRANCH" '
{
  name: $name,
  target: "branch",
  enforcement: "active",
  conditions: { ref_name: { include: [$branch], exclude: [] } },
  bypass_actors: [],
  rules: [
    {
      type: "required_status_checks",
      parameters: {
        strict: false,
        contexts: ["Vercel"]  # ← le statut vert de Vercel
      }
    }
  ]
}
')"

if [[ -n "$EXISTING_ID" ]]; then
  echo "• Ruleset déjà présent (#$EXISTING_ID) → PATCH mise à jour…"
  printf '%s' "$BODY" \
    | gh api -X PATCH -H "Accept: application/vnd.github+json" \
      "/repos/$OWNER/$REPO/rulesets/$EXISTING_ID" \
      --input -
  echo "✓ Ruleset mis à jour."
else
  echo "• Ruleset absent → création…"
  printf '%s' "$BODY" \
    | gh api -X POST -H "Accept: application/vnd.github+json" \
      "/repos/$OWNER/$REPO/rulesets" \
      --input -
  echo "✓ Ruleset créé."
fi
