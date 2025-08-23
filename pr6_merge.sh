#!/usr/bin/env bash
set -euo pipefail

# Neutraliser alias/override git
unalias git 2>/dev/null || true
if declare -F git >/dev/null 2>&1; then
  unset -f git || true
fi

PR="${PR_NUMBER:-6}"
BASE_REMOTE="${BASE_REMOTE:-origin}"
BASE_BRANCH="${BASE_BRANCH:-main}"

# S'assure d'abord que local 'main' tracke bien origin/main (évite toutes les erreurs vues)
./git-ensure-main.sh

# Petite review best-effort (ignore si pas possible)
gh pr review "$PR" --approve || true

if [[ "${ADMIN:-0}" == "1" ]]; then
  echo "== Admin merge (squash + delete-branch) =="
  gh pr merge "$PR" --squash --delete-branch --admin
else
  echo "== Auto-merge activé (squash). La PR se fusionnera dès que tout est vert =="
  gh pr merge "$PR" --squash --auto
fi

# Sync local main (sans gueuler si pas nécessaire)
command git checkout "$BASE_BRANCH" >/dev/null 2>&1 || true
command git fetch "$BASE_REMOTE" --prune
command git pull --ff-only "$BASE_REMOTE" "$BASE_BRANCH" || true

echo "✓ Merge/Auto-merge OK (ou en attente des checks)."
