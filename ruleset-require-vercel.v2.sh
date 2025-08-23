#!/usr/bin/env bash
set -euo pipefail
OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"
BRANCH="${BRANCH:-~DEFAULT_BRANCH}"   # ou "refs/heads/main"
RULESET_NAME="${RULESET_NAME:-Require Vercel Checks (main)}"

# 1) Cherche un ruleset du même nom
EXISTING_ID="$(gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/rulesets?per_page=100" \
  | jq -r --arg NAME "$RULESET_NAME" '.[] | select(.name==$NAME) | .id' | head -n1)"

# 2) Corps JSON conforme Rulesets: type=required_status_checks + parameters.required_checks
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
        # n.b. "integration_id" optionnel; on force seulement le "context"
        required_checks: [ { context: "Vercel" } ],
        strict_required_status_checks_policy: false,
        do_not_enforce_on_create: true
      }
    }
  ]
}
')"

if [[ -n "$EXISTING_ID" ]]; then
  echo "• Ruleset existe (#$EXISTING_ID) → PATCH"
  printf '%s' "$BODY" \
   | gh api -X PATCH -H "Accept: application/vnd.github+json" \
     "/repos/$OWNER/$REPO/rulesets/$EXISTING_ID" --input -
  echo "✓ Ruleset mis à jour."
else
  echo "• Création du ruleset…"
  printf '%s' "$BODY" \
   | gh api -X POST -H "Accept: application/vnd.github+json" \
     "/repos/$OWNER/$REPO/rulesets" --input -
  echo "✓ Ruleset créé."
fi
