#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

MODE="${MODE:-commit}"  # commit | stash
BR="chore/wip-$(date +%Y%m%d-%H%M%S)"
MSG="${MSG:-chore(wip): park local work safely}"

git rev-parse --is-inside-work-tree >/dev/null

echo "== WIP status =="
git status --porcelain=v1 || true
echo

if [[ "$MODE" == "stash" ]]; then
  git stash push -u -m "$MSG"
  echo "✓ WIP stashed →"
  git stash list | head -n1
  exit 0
fi

# MODE=commit : branche dédiée + exclusions safe
git fetch origin --prune
git checkout -B "$BR" origin/main || git checkout -b "$BR"

# Ajoute tout sauf dossiers lourds / secrets connus
git add -A \
  ':!node_modules' ':!dist' ':!.vercel' ':!.vercel/output' \
  ':!*.log' ':!.env' ':!.env.*' ':!**/*.env' ':!.DS_Store' ':!.pnpm-store' \
  ':!.cache' ':!.next' ':!coverage' ':!.turbo' ':!.vite' ':!tmp' ':!**/*.lock'

if git diff --cached --quiet; then
  echo "Rien à committer (après exclusions)."
  exit 0
fi

git commit -m "$MSG"
git push -u origin "$BR" --force-with-lease
echo "✓ WIP commité & poussé sur ${BR}"
