#!/usr/bin/env bash
set -euo pipefail
OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"
BRANCH="${BRANCH:-main}"

# Payload: nouvelle API "checks" (contexts est déprécié)
BODY="$(jq -n '
{
  required_status_checks: {
    strict: false,
    checks: [ { context: "Vercel" } ]
  },
  enforce_admins: true,
  required_pull_request_reviews: null,
  restrictions: null
}
')"

gh api -X PUT -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/branches/$BRANCH/protection" \
  --input <(printf '%s' "$BODY")

echo "✓ Classic branch protection mise à jour (Vercel requis)"
