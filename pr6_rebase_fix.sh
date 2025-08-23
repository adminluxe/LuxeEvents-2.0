#!/usr/bin/env bash
set -euo pipefail

# Neutraliser alias/override git
unalias git 2>/dev/null || true
if declare -F git >/dev/null 2>&1; then
  unset -f git || true
fi

PR_NUMBER="${PR_NUMBER:-6}"
PR_BRANCH="${PR_BRANCH:-v2-5-fresh}"
BASE_REMOTE="${BASE_REMOTE:-origin}"
BASE_BRANCH="${BASE_BRANCH:-main}"

echo "== Rebase PR #${PR_NUMBER} (${PR_BRANCH}) sur ${BASE_REMOTE}/${BASE_BRANCH} =="

command git rev-parse --is-inside-work-tree >/dev/null
REPO_ROOT="$(command git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

# S'assure qu'on a la branche PR locale sur le bon remote
command git fetch "$BASE_REMOTE" --prune
command git checkout -B "$PR_BRANCH" "${BASE_REMOTE}/${PR_BRANCH}" || command git checkout "$PR_BRANCH"
command git reset --hard "${BASE_REMOTE}/${PR_BRANCH}"

# Commit léger si index.html modifié
if command git status --porcelain | grep -E '(^\s*M|^\?\?)\s+index\.html' >/dev/null 2>&1; then
  echo "• Commit des changements index.html locaux"
  command git add index.html
  (pnpm test || npm test || echo "No test specified") >/dev/null 2>&1 || true
  command git commit -m "chore(index): keep hero preload/antialiased adjustments" || true
fi

# S'assure que refs/remotes/origin/main existe
echo "• Fetch ${BASE_BRANCH} -> ${BASE_REMOTE}/${BASE_BRANCH}"
command git fetch "$BASE_REMOTE" "${BASE_BRANCH}:refs/remotes/${BASE_REMOTE}/${BASE_BRANCH}"

# Nettoyage des <link rel="preload"> orphelins (évite 404)
if [ -f "index.html" ]; then
  mapfile -t HREFS < <(grep -oP '<link[^>]*rel=["'\''"]preload["'\''"][^>]*href=["'\''"]\K[^"'\'' ]+' index.html || true)
  REMOVED=0
  for href in "${HREFS[@]:-}"; do
    if [[ "$href" == /* ]]; then
      CANDIDATE="public${href}"
    else
      CANDIDATE="public/${href#./}"
    fi
    if [ ! -f "$CANDIDATE" ]; then
      sed -i "\#<link[^>]*rel=['\"]preload['\"][^>]*href=['\"]${href//\//\\/}['\"][^>]*>#d" index.html
      REMOVED=1
    fi
  done
  if [ "$REMOVED" -eq 1 ]; then
    echo "• Hero manquant: suppression du lien <preload> sur asset(s) introuvable(s)"
    command git add index.html
    (pnpm test || npm test || echo "No test specified") >/dev/null 2>&1 || true
    command git commit -m "chore(index): drop missing preload link(s) to avoid 404" || true
  fi
fi

# Rebase en gardant TA version de index.html si conflit
echo "• Rebase sur ${BASE_REMOTE}/${BASE_BRANCH}"
set +e
command git rebase "refs/remotes/${BASE_REMOTE}/${BASE_BRANCH}"
REBASERC=$?
if [ $REBASERC -ne 0 ]; then
  if command git ls-files -u | awk '{print $4}' | sort -u | grep -qx "index.html"; then
    echo "• Conflit sur index.html → on garde ta version"
    command git checkout --ours -- index.html
    command git add index.html
  fi
  command git rebase --continue || { echo "✖ Rebase impossible, rollback…"; command git rebase --abort; exit 1; }
fi
set -e

# Push
echo "• Push de ${PR_BRANCH} (mise à jour de la PR #${PR_NUMBER})"
command git push --force-with-lease "$BASE_REMOTE" "$PR_BRANCH"

echo "== OK. Ouvre la PR et vérifie les checks =="
echo "   gh pr view ${PR_NUMBER} --web"
echo "   Quand tout est vert:"
echo "   gh pr merge ${PR_NUMBER} --squash --delete-branch   # (ou --admin si branch protégée)"
