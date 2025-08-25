#!/usr/bin/env bash
set -euo pipefail
cd "${REPO_DIR:-$HOME/luxeevents-frontend-clean}"

git fetch origin --prune
git checkout main
git reset --hard origin/main
git tag -f v2.5.2 origin/main
git push -f origin v2.5.2

# Smoke ultra-rapide
for U in / /bg-luxeevents.png /logo_gold_black.png /images/gallery/thumb1.png; do
  echo "TEST $U"; curl -I "https://www.luxeevents.me$U" | head -n1
done
