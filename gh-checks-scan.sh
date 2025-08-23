#!/usr/bin/env bash
set -euo pipefail
PR="${1:-6}"
OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"

SHA="$(gh pr view "$PR" --json headRefOid -q .headRefOid)"
echo "== Checks sur $OWNER/$REPO @ $SHA (PR #$PR) =="

echo "— check-runs (Checks API) —"
gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/commits/$SHA/check-runs" \
| jq -r '.check_runs[] | [.name, .conclusion, .status, .details_url, (.app.slug // "no-app")] | @tsv' \
| awk -F'\t' '{printf "• %-24s | concl=%-9s | status=%-9s | app=%-18s | %s\n",$1,$2,$3,$5,$4}'

echo
echo "— commit statuses (legacy) —"
gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/commits/$SHA/status" \
| jq -r '.statuses[] | [.context, .state, .target_url] | @tsv' \
| awk -F'\t' '{printf "• %-24s | state=%-7s | %s\n",$1,$2,$3}'

echo
echo "Astuce: si app=cloudflare-pages → GitHub App. Si context/action mentionne 'cloudflare/pages-action' → workflow Actions."
