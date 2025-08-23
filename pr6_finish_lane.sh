#!/usr/bin/env bash
set -euo pipefail

PR="${PR_NUMBER:-6}"
BASE_REMOTE="${BASE_REMOTE:-origin}"
BASE_BRANCH="${BASE_BRANCH:-main}"
PR_BRANCH="${PR_BRANCH:-v2-5-fresh}"

# Neutralise les alias/overrides git (sources d'anciens refspec chelous)
unalias git 2>/dev/null || true
if declare -F git >/dev/null 2>&1; then
  unset -f git || true
fi

echo "== PR #$PR • Finish Lane (rebase → merge) =="

# 1) S’assure que local 'main' → origin/main
./git-ensure-main.sh

# 2) Rebase + push PR (garde ton index.html et nettoie preloads orphelins)
./pr6_rebase_fix.sh

# 3) Lancer merge
if [[ "${ADMIN:-0}" == "1" ]]; then
  echo "== Merge immédiat (admin, squash + delete-branch) =="
  gh pr merge "$PR" --squash --delete-branch --admin
else
  echo "== Auto-merge activé (squash). La PR fusionnera dès que tout est vert =="
  gh pr merge "$PR" --squash --auto || true
fi

# 4) (optionnel) Suivi des checks en temps réel
gh pr checks "$PR" --watch || true

# 5) Attendre MERGED (jusqu’à 30 essais ~1min). Si pas MERGED → on sort sans erreur.
for i in $(seq 1 30); do
  STATE="$(gh pr view "$PR" --json state -q .state 2>/dev/null || echo "UNKNOWN")"
  if [[ "$STATE" == "MERGED" ]]; then
    echo "✓ PR #$PR est MERGED"
    break
  fi
  sleep 2
done

# 6) Sync local main & ménage léger
git checkout "$BASE_BRANCH" >/dev/null 2>&1 || true
git fetch "$BASE_REMOTE" --prune
git pull --ff-only "$BASE_REMOTE" "$BASE_BRANCH" || true

# Si la PR est mergée et que la branche locale existe encore → on la supprime localement
if git show-ref --verify --quiet "refs/heads/${PR_BRANCH}"; then
  if [[ "$(gh pr view "$PR" --json state -q .state 2>/dev/null || echo "OPEN")" == "MERGED" ]]; then
    git branch -D "$PR_BRANCH" || true
  fi
fi

echo "== Finish Lane terminé. Si auto-merge: la fusion se fera dès que tous les checks sont ✅ =="
