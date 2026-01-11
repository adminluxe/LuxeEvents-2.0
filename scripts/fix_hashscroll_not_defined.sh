#!/usr/bin/env bash
set -euo pipefail

f="src/main.jsx"
[ -f "$f" ] || { echo "❌ Introuvable: $f"; exit 1; }

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"
cp -a "$f" "$bdir/main.jsx.bak"

# Détecte quel composant existe réellement
NAME=""
PATH=""
if [ -f "src/components/HashScroller.jsx" ]; then
  NAME="HashScroller"
  PATH="./components/HashScroller.jsx"
elif [ -f "src/components/HashScroll.jsx" ]; then
  NAME="HashScroll"
  PATH="./components/HashScroll.jsx"
else
  # dernier recours: on crée HashScroller.jsx minimal
  NAME="HashScroller"
  PATH="./components/HashScroller.jsx"
  mkdir -p src/components
  cat > src/components/HashScroller.jsx <<'JSX'
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

export default function HashScroller() {
  const { hash } = useLocation();

  useEffect(() => {
    if (!hash) return;

    // petit délai pour laisser le DOM se monter
    const t = setTimeout(() => {
      const id = hash.replace("#", "");
      const el = document.getElementById(id);
      if (!el) return;

      const nav = document.querySelector("header, nav");
      const offset = nav ? nav.getBoundingClientRect().height + 12 : 84;

      const y = el.getBoundingClientRect().top + window.scrollY - offset;
      window.scrollTo({ top: Math.max(0, y), behavior: "smooth" });
    }, 60);

    return () => clearTimeout(t);
  }, [hash]);

  return null;
}
JSX
  echo "✅ Créé: src/components/HashScroller.jsx"
fi

echo "==> Mode: utiliser ${NAME} (${PATH})"

# 1) Remplace toutes les occurrences HashScroll/HashScroller par le bon NAME
# (ça fixe le JSX + l'import)
perl -pi -e 's/\bHashScroll\b/'"$NAME"'/g; s/\bHashScroller\b/'"$NAME"'/g' "$f"

# 2) Force un import correct si absent ou mauvais
if grep -qE 'import\s+.*HashScroll' "$f" || grep -qE 'import\s+.*HashScroller' "$f"; then
  # remplace la ligne d'import existante
  perl -pi -e 's|^import\s+\w+\s+from\s+["'\'']\./components/(HashScroll|HashScroller)\.jsx["'\''];|import '"$NAME"' from "'"$PATH"'";|g' "$f"
else
  # injecte l'import après react-router-dom si présent, sinon en haut
  if grep -q "from \"react-router-dom\"" "$f"; then
    perl -0777 -pi -e 's/(from\s+"react-router-dom";\s*\n)/$1import '"$NAME"' from "'"$PATH"'";\n/s' "$f"
  else
    perl -0777 -pi -e 's/^(import.*\n)/$1import '"$NAME"' from "'"$PATH"'";\n/s' "$f"
  fi
fi

echo "==> Aperçu import + usage:"
grep -nE "import ${NAME}|<${NAME}\b" "$f" || true

echo "✅ Done. Backup: $bdir"
