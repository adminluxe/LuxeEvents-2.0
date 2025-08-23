#!/usr/bin/env bash
set -euo pipefail

OWNER="${GITHUB_USERNAME:-adminluxe}"
REPO="LuxeEvents-2.0"
BRANCH="main"

echo "== Rules (résolus) sur $BRANCH (via Rulesets) =="
gh api -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/rules/branches/$BRANCH \
  --jq '.[] | select(.type=="required_status_checks")' || true

echo
echo "== Branch protection (classique) =="
gh api -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/branches/$BRANCH/protection \
  --jq '{required_status_checks: (.required_status_checks // {}), enforce_admins}'
