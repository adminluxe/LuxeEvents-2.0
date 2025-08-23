#!/usr/bin/env bash
set -euo pipefail

OWNER="${GITHUB_USERNAME:-adminluxe}"
REPO="LuxeEvents-2.0"
BRANCH="main"

gh api -X PUT \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/branches/$BRANCH/protection \
  --input <(cat <<'JSON'
{
  "required_status_checks": {
    "strict": false,
    "checks": [
      { "context": "Vercel" }
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": false,
  "lock_branch": false,
  "allow_fork_syncing": false
}
JSON
)

echo "✓ Branch protection classique: seul le check 'Vercel' est requis sur ${BRANCH}."
