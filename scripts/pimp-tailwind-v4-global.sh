#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_tailwind_global_${ts}"
mkdir -p "$BACKUP"

entry=""
if [ -f src/main.jsx ]; then entry="src/main.jsx"; fi
if [ -z "${entry}" ] && [ -f src/main.tsx ]; then entry="src/main.tsx"; fi

if [ -z "${entry}" ]; then
  echo "❌ No entry file found (expected src/main.jsx or src/main.tsx)."
  exit 1
fi

css="src/index.css"

echo "📦 Backup -> $BACKUP"
cp -a "$entry" "$BACKUP/$(basename "$entry")"

if [ -f "$css" ]; then
  cp -a "$css" "$BACKUP/$(basename "$css")"
fi

echo "🔧 1) Ensure global CSS import in $entry"
if ! grep -qE 'import\s+["'\'']\./index\.css["'\'']' "$entry"; then
  # Insert import "./index.css"; after first import line
  awk '
    NR==1 { print; next }
    NR==2 && inserted==0 {
      print "import \"./index.css\";";
      inserted=1;
      print;
      next
    }
    { print }
    END {
      if (inserted==0) {
        # Fallback: append at top if file is weird
      }
    }
  ' "$entry" > "$entry.__tmp__" && mv "$entry.__tmp__" "$entry"

  # If insertion failed due to file structure, do a safer prepend
  if ! grep -qE 'import\s+["'\'']\./index\.css["'\'']' "$entry"; then
    sed -i '1i import "./index.css";' "$entry"
  fi
else
  echo "   ✅ already imports ./index.css"
fi

echo "🔧 2) Ensure Tailwind v4 directives in $css"
if [ ! -f "$css" ]; then
  cat > "$css" <<'EOF'
@import "tailwindcss";
@source "./**/*.{js,jsx,ts,tsx}";

/* Base minimal (optionnel) */
html, body, #root { height: 100%; }
EOF
else
  # Ensure @import "tailwindcss";
  if ! grep -qE '^\s*@import\s+"tailwindcss";\s*$' "$css"; then
    # If file has old v3 directives, we keep them and add v4 import on top
    sed -i '1i @import "tailwindcss";' "$css"
  fi

  # Ensure @source ...
  if ! grep -qE '^\s*@source\s+"\./\*\*/\*\.\{js,jsx,ts,tsx\}";\s*$' "$css"; then
    # Put @source right after the first @import "tailwindcss";
    awk '
      BEGIN{done=0}
      {
        print
        if (done==0 && $0 ~ /^\s*@import\s+"tailwindcss";\s*$/) {
          print "@source \"./**/*.{js,jsx,ts,tsx}\";";
          done=1
        }
      }
    ' "$css" > "$css.__tmp__" && mv "$css.__tmp__" "$css"
  fi

  # Ensure minimal root height (helps layout)
  if ! grep -qE 'html,\s*body,\s*#root\s*\{\s*height:\s*100%;' "$css"; then
    printf "\nhtml, body, #root { height: 100%%; }\n" >> "$css"
  fi
fi

echo "✅ Tailwind global lock applied."
echo "▶️ Now restart dev: Ctrl+C then pnpm dev -- --port 5173 --strictPort"
