#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

echo "🔎 1) Detect Vite ports in use (5173/5174) ..."
for p in 5173 5174; do
  if lsof -iTCP:"$p" -sTCP:LISTEN -nP >/dev/null 2>&1; then
    echo "⚠️  Port $p is LISTENING:"
    lsof -iTCP:"$p" -sTCP:LISTEN -nP | sed -n '1,5p'
  else
    echo "✅ Port $p free"
  fi
done

echo ""
echo "🧼 2) Hardcoded /devis check (exclude backups, node_modules, dist)"
echo "----"
grep -RIn \
  --exclude-dir=node_modules --exclude-dir=dist --exclude='*.bak*' \
  -E 'href=["'\'']\/devis["'\'']|to=["'\'']\/devis["'\'']' \
  src \
  | head -n 200 || true
echo "----"

echo ""
echo "🧼 3) Duplicate PrimaryCTA import check (same file, multiple imports)"
# show files that have >1 import PrimaryCTA line
awk '
  FNR==1{count=0; file=FILENAME}
  /^import[[:space:]]+PrimaryCTA/ {count++}
  ENDFILE { if (count>1) print file " => " count " imports" }
' $(find src -type f \( -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o -name "*.tsx" \) \
   ! -name "*.bak*" ) 2>/dev/null || true

echo ""
echo "✅ If section (2) is empty AND section (3) empty => CTA system is 100% locked."
echo ""
echo "▶️ Run dev (preferred port 5173):"
echo "   pnpm dev -- --port 5173"
echo "   (or if already in use: pnpm dev -- --port 5174)"
