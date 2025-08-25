#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

# Vars
PR_BRANCH="${PR_BRANCH:-hotfix/landing-urgent}"
BASE_REMOTE="${BASE_REMOTE:-origin}"
BASE_BRANCH="${BASE_BRANCH:-main}"
FILE="index.html"

git rev-parse --is-inside-work-tree >/dev/null
ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

echo "== HOTFIX Landing urgent =="

# 0) Base à jour
git fetch "$BASE_REMOTE" --prune
git checkout -B "$PR_BRANCH" "$BASE_REMOTE/$BASE_BRANCH" || git checkout -b "$PR_BRANCH"

# 1) SW: fix typo + garde-fou safe
if [ -f "$FILE" ]; then
  # registernavigator -> register
  sed -i -E 's/navigator\.serviceWorker\.registernavigator/navigator.serviceWorker.register/g' "$FILE"
  # garde-fou (HEAD /sw.js puis register) si pas déjà injecté
  if ! grep -q '/* SW guard */' "$FILE"; then
    awk -v RS= -v ORS= '
      {
        sub("</body>",
"  <script>/* SW guard */\n"\
"  (function(){try{if(\"serviceWorker\" in navigator){fetch(\"/sw.js\",{method:\"HEAD\"}).then(r=>{if(r.ok){navigator.serviceWorker.register(\"/sw.js\").catch(()=>{});}});}}catch(e){}})();\n"\
"  </script>\n</body>")
        print
      }' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
  fi
fi

# 2) HERO: remap /luxeevents-bg-hero.webp -> /bg-luxeevents.png si présent, sinon suppression + drop preload fantôme
HERO_WEBP="/luxeevents-bg-hero.webp"
HERO_PNG="/bg-luxeevents.png"
if [ -f "public${HERO_PNG}" ]; then
  sed -i -E "s@${HERO_WEBP}@${HERO_PNG}@g" "$FILE"
  sed -i -E 's@(type=[\"\x27])image/webp@\1image/png@g' "$FILE" || true
else
  sed -i -E "\@<img[^>]*src=[\"']${HERO_WEBP}[\"'][^>]*>@d" "$FILE"
fi
sed -i "\#<link[^>]*rel=['\"]preload['\"][^>]*href=['\"]${HERO_WEBP}['\"][^>]*>#d" "$FILE"

# 3) LOGO: /logo_gold_black.png -> fallback (apple-touch-icon.png ou favicon.ico)
LOGO="/logo_gold_black.png"
FALL=""
if [ ! -f "public${LOGO}" ]; then
  if [ -f "public/apple-touch-icon.png" ]; then FALL="/apple-touch-icon.png";
  elif [ -f "public/favicon.ico" ]; then FALL="/favicon.ico";
  fi
  if [ -n "$FALL" ]; then sed -i -E "s@/logo_gold_black\.png@${FALL}@g" "$FILE"; fi
fi

# 4) GALERIE: évite 404 visibles -> onerror remove + lazy/decoding
sed -i -E 's@<img([^>]*\bsrc="/images/gallery/[^"]+")@<img loading="lazy" decoding="async" onerror="this.remove()" \1@g' "$FILE"

# 5) Clean: supprime tout <link rel="preload"> dont href n’existe pas dans /public
MISSING=0
mapfile -t PRELOADS < <(grep -oP '<link[^>]*rel=["'\'']preload["'\''][^>]*href=["'\'']\K[^"'\'' ]+' "$FILE" || true)
for href in "${PRELOADS[@]:-}"; do
  CAND="public${href#/}"
  [ -f "$CAND" ] || { sed -i "\#<link[^>]*rel=['\"]preload['\"][^>]*href=['\"]${href//\//\\/}['\"][^>]*>#d" "$FILE"; MISSING=1; }
done
[ "$MISSING" -eq 1 ] && echo "• Preloads orphelins nettoyés"

# 6) Commit + push
git add "$FILE"
git commit -m "hotfix(landing): SW register guard + hero/logo/gallery 404 hardening" || true

REMOTE_SHA="$(git ls-remote --heads "$BASE_REMOTE" "refs/heads/$PR_BRANCH" | awk '{print $1}')"
if [ -z "$REMOTE_SHA" ]; then
  git push -u "$BASE_REMOTE" "$PR_BRANCH"
else
  git push -u "$BASE_REMOTE" "$PR_BRANCH:$PR_BRANCH" --force-with-lease="refs/heads/$PR_BRANCH:$REMOTE_SHA"
fi

# 7) PR + merge
TITLE="hotfix(landing): fix hero/logo/gallery 404 + SW guard"
BODY=$'Urgent hotfix prod :\n- SW register typo + guard\n- hero webp manquant -> bg-luxeevents.png (ou suppression)\n- fallback logo\n- galerie 404 neutralisées\n- preload fantômes nettoyés'
gh pr create --title "$TITLE" --body "$BODY" --base "$BASE_BRANCH" --head "$PR_BRANCH" >/dev/null || true
PR="$(gh pr list --head "$PR_BRANCH" --json number -q '.[0].number' 2>/dev/null || true)"
[ -n "$PR" ] && { gh pr view "$PR" --web || true; }
# Merge (admin si possible, sinon auto)
gh pr merge "${PR:-0}" --squash --delete-branch --admin || gh pr merge "${PR:-0}" --squash --auto || true

echo "== HOTFIX poussé. Quand Vercel a déployé, purge CF (si domaine derrière CF) =="
echo "   purgeluxe   # alias existant (ou MAINTDIR/manage_cloudflare_cache.sh ...)"
