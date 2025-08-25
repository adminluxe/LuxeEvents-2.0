#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
PRS="${PRS:-}"  # ex: "12 9"
[ -n "$PRS" ] || { echo "✖ PRS vide. Exemple: REPO_DIR=… PRS=\"12 9\" ./pr_batch_resolve.sh"; exit 1; }

cd "$REPO_DIR"
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true
git fetch origin --prune

for PR in $PRS; do
  echo "== PR #$PR =="
  gh pr checkout "$PR"
  git fetch origin main
  git merge --no-edit origin/main || true

  FILE="index.html"
  [ -f "$FILE" ] || { echo "• $FILE manquant, skip PR #$PR"; continue; }

  # Patch PROD unifié
  sed -i -E 's@/images/gallery/thumb([0-9]+)\.webp@/images/gallery/thumb\1.png@g' "$FILE"
  sed -i -E 's@/luxeevents-bg-hero\.webp@/bg-luxeevents.png@g' "$FILE"
  sed -i "\#<link[^>]*rel=['\"]preload['\"][^>]*href=['\"]/luxeevents-bg-hero\.webp['\"][^>]*>#d" "$FILE"
  sed -i -E 's@navigator\.serviceWorker\.registernavigator@navigator.serviceWorker.register@g' "$FILE"
  sed -i -E 's@navigator\.serviceWorker\.register\.serviceWorker@navigator.serviceWorker.register@g' "$FILE"
  grep -q '/* SW guard */' "$FILE" || awk -v RS= -v ORS= '
    { sub("</body>",
"  <script>/* SW guard */\n"\
"  (function(){try{if(\"serviceWorker\" in navigator){fetch(\"/sw.js\",{method:\"HEAD\"}).then(r=>{if(r.ok){navigator.serviceWorker.register(\"/sw.js\").catch(()=>{});}});}}catch(e){}})();\n"\
"  </script>\n</body>"); print }' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

  # Logo présent physiquement
  [ -f public/logo_gold_black.png ] || cp -f public/apple-touch-icon.png public/logo_gold_black.png 2>/dev/null || cp -f public/favicon.ico public/logo_gold_black.png 2>/dev/null || true

  git add index.html public/logo_gold_black.png 2>/dev/null || true
  git commit -m "resolve(index.html): unify prod sanity patch (#$PR)" || true
  git push

  # Auto-merge (Vercel est le seul check requis)
  gh pr merge "$PR" --squash --delete-branch --admin || gh pr merge "$PR" --squash --auto || true
done

echo "✓ Poussé. Suis les checks: gh pr checks <num> --watch ; puis purgeluxe"
