#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

CSS="src/index.css"
[ -f "$CSS" ] || { echo "❌ $CSS not found"; exit 1; }

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_indexcss_order_${ts}"
mkdir -p "$BACKUP"
cp -a "$CSS" "$BACKUP/index.css"
echo "📦 Backup -> $BACKUP/index.css"

awk '
  BEGIN {
    has_tailwind=0
    has_source=0
    charset=""
    nimp=0
    nbody=0
  }

  function add_import(line, key) {
    if (!(key in seen)) {
      seen[key]=1
      imports[++nimp]=line
    }
  }

  {
    line=$0

    # keep @charset if any (only first)
    if (match(line, /^[[:space:]]*@charset[[:space:]]+/)) {
      if (charset=="") charset=line
      next
    }

    # capture @import lines (anywhere)
    if (match(line, /^[[:space:]]*@import[[:space:]]+/)) {
      # normalize key to avoid duplicates
      key=line
      gsub(/[[:space:]]+/, " ", key)
      gsub(/[[:space:]]*;[[:space:]]*$/, ";", key)

      if (line ~ /@import[[:space:]]+"tailwindcss";/) {
        has_tailwind=1
        next
      }
      add_import(line, key)
      next
    }

    # capture @source (only keep last one)
    if (match(line, /^[[:space:]]*@source[[:space:]]+"/)) {
      source=line
      has_source=1
      next
    }

    # Tailwind v3 legacy directives: skip (v4 uses @import "tailwindcss";)
    if (match(line, /^[[:space:]]*@tailwind[[:space:]]+(base|components|utilities)[[:space:]]*;?[[:space:]]*$/)) {
      next
    }

    # otherwise keep in body
    body[++nbody]=line
  }

  END {
    if (charset!="") print charset
    print "@import \"tailwindcss\";"

    for (i=1;i<=nimp;i++) print imports[i]

    if (has_source) print source
    else print "@source \"./**/*.{js,jsx,ts,tsx}\";"

    print ""

    # Ensure root height (helps layout consistency)
    has_height=0
    for (i=1;i<=nbody;i++) {
      if (body[i] ~ /html[[:space:]]*,[[:space:]]*body[[:space:]]*,[[:space:]]*#root[[:space:]]*\{[[:space:]]*height:[[:space:]]*100%/) has_height=1
    }

    for (i=1;i<=nbody;i++) print body[i]

    if (!has_height) {
      print ""
      print "html, body, #root { height: 100%; }"
    }
  }
' "$CSS" > "$CSS.__tmp__" && mv "$CSS.__tmp__" "$CSS"

echo "✅ index.css fixed: all @import are at the top, @source after, legacy @tailwind removed."
echo "▶️ Restart dev: Ctrl+C then pnpm dev -- --port 5173 --strictPort"
