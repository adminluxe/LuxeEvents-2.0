#!/usr/bin/env bash
set -euo pipefail
OWNER="${GITHUB_USERNAME:-adminluxe}"
REPO="LuxeEvents-2.0"
BRANCH="main"

echo "== Required checks (classique) sur ${BRANCH} =="
REQ=$(gh api -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/branches/$BRANCH/protection \
  --jq '.required_status_checks.checks[].context' 2>/dev/null || echo "")
if [ -z "$REQ" ]; then
  echo "  (aucun)"; exit 0
fi
echo "$REQ" | sed 's/^/  • /'

echo
echo "== Conseils =="
echo "• Seul ce(s) check(s) bloque(nt) les merges. Tout le reste (ex: Cloudflare Pages) est cosmétique."
echo "• Mode strict actuel : $(gh api -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/branches/$BRANCH/protection \
  --jq '.required_status_checks.strict')"
