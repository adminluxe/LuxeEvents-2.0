#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

BR="$(git rev-parse --abbrev-ref HEAD)"
REMOTE_SHA="$(git ls-remote --heads origin "refs/heads/$BR" | awk '{print $1}')"

if [ -z "$REMOTE_SHA" ]; then
  echo "• Aucun remote pour $BR → premier push sans lease"
  git push -u origin "$BR"
else
  echo "• Remote $BR existe ($REMOTE_SHA) → push avec lease explicite"
  git push -u origin "$BR:$BR" --force-with-lease="refs/heads/$BR:$REMOTE_SHA"
fi

echo "✓ Push OK → $BR"
