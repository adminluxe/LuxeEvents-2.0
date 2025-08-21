#!/usr/bin/env bash
set -euo pipefail

echo "== V2.5 CSS nits =="

css_files=()
log_files=()

echo "— Prune: -moz-osx-font-smoothing"
mapfile -t css_files < <(grep -RIl --exclude-dir={node_modules,.git,.vite,dist,build} --exclude v2_5_css_nits.sh --include='*.css' '\-moz-osx-font-smoothing' . || true)
if (( ${#css_files[@]} )); then
  for f in "${css_files[@]}"; do
    sed -i -e '/-moz-osx-font-smoothing/d' "$f"
    echo "  cleaned: $f"
  done
else
  echo "  rien à nettoyer."
fi

mapfile -t log_files < <(grep -RIl --exclude-dir={node_modules,.git,.vite,dist,build} --exclude v2_5_css_nits.sh -E 'console\.log\([^)]*antialiased' . || true)
if (( ${#log_files[@]} )); then
  for f in "${log_files[@]}"; do
    sed -i -E '/console\.log/ { /antialiased/ d; }' "$f"
    echo "  muted: $f"
  done
else
  echo "  rien à muter."
fi

echo "— Ensure <html> a la classe 'antialiased' dans index.html"
if [[ -f index.html ]]; then
  if grep -qE '<html[^>]*class=' index.html; then
    if ! grep -qE '<html[^>]*class="[^"]*\bantialiased\b' index.html; then
      sed -i -E 's/(<html[^>]*class=")([^"]*)"/\1\2 antialiased"/' index.html
      echo "  ajouté 'antialiased' à la classe existante."
    else
      echo "  déjà présent."
    fi
  else
    sed -i -E 's/<html(\b)/<html class="antialiased"\1/' index.html
    echo "  ajouté l’attribut class sur <html>."
  fi
else
  echo "  ⚠ index.html introuvable — étape ignorée."
fi

echo "✓ Fini. Fais un hard reload (Ctrl+F5)."
