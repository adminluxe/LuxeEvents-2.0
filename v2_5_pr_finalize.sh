#!/usr/bin/env bash
set -euo pipefail

echo "== V2.5 finalize (wrapper services + hero preload + push) =="

ROOT="$(pwd)"
BRANCH="$(git rev-parse --abbrev-ref HEAD || true)"
echo "• Branch courante: $BRANCH"

# 1) Wrapper services
mkdir -p src/data
WRAP="src/data/services.luxe.wrap.js"
cat > "$WRAP" <<'JS'
import * as S from './services.luxe.js';

// Normalise tous les cas possibles sans casser si une clé est absente
const services =
  (S && (S.services || S.default || S.luxeServices || S.data)) || [];

export { services };
export default services;
JS
echo "• Wrapper créé: $WRAP"

# 2) Patch ServicesSection.jsx pour consommer le wrapper
COMP="src/components/ServicesSection.jsx"
if [[ -f "$COMP" ]]; then
  cp -n "$COMP" "$COMP.bak.$(date +%Y%m%d-%H%M%S)" || true
  # vire tous les imports depuis services.luxe.js
  sed -i -E '/from[[:space:]]*[\"\x27]\.\.\/data\/services\.luxe\.js[\"\x27][[:space:]]*;[[:space:]]*$/d' "$COMP"
  sed -i -E '/from[[:space:]]*[\"\x27]\.\/\.\.\/data\/services\.luxe\.js[\"\x27][[:space:]]*;[[:space:]]*$/d' "$COMP"

  # si déjà patché, on ne réinsère pas
  if ! grep -q 'services\.luxe\.wrap\.js' "$COMP"; then
    # injecte après le dernier import
    awk '
      BEGIN{last=0}
      {print; if($0 ~ /^[[:space:]]*import /) last=NR}
      END{
        # Le bloc s’imprime juste après la dernière ligne d’import
      }
    ' "$COMP" > "$COMP.tmp"

    awk -v file="$COMP.tmp" '
      BEGIN{
        while((getline l<file)>0){a[++n]=l} close(file)
        last=0
        for(i=1;i<=n;i++){ if(a[i] ~ /^[ \t]*import /) last=i }
        for(i=1;i<=n;i++){
          print a[i]
          if(i==last){
            print "import servicesDefault, { services as servicesNamed } from \"../data/services.luxe.wrap.js\";"
            print "const services = servicesNamed || servicesDefault || [];"
          }
        }
      }' > "$COMP.patched"

    mv "$COMP.patched" "$COMP"
    rm -f "$COMP.tmp"
    echo "• ${COMP} patché (utilise le wrapper)."
  else
    echo "• ${COMP} déjà patché, ok."
  fi
else
  echo "⚠ ${COMP} introuvable (skippé)."
fi

# 3) Hero: déplacer l’image dans public/ et preload correct
mkdir -p public
if [[ -f "luxeevents-bg-hero.webp" ]]; then
  mv -f "luxeevents-bg-hero.webp" public/
elif [[ -f "src/assets/luxeevents-bg-hero.webp" ]]; then
  cp -f "src/assets/luxeevents-bg-hero.webp" public/
elif [[ -f "images/luxeevents-bg-hero.webp" ]]; then
  cp -f "images/luxeevents-bg-hero.webp" public/
fi
if [[ -f "public/luxeevents-bg-hero.webp" ]]; then
  echo "• Hero image OK: public/luxeevents-bg-hero.webp"
else
  echo "⚠ Hero image introuvable. Mets-la dans public/luxeevents-bg-hero.webp si besoin."
fi

# Fix index.html: classe antialiased + preload + nettoyer 'falsenavigator'
if [[ -f "index.html" ]]; then
  cp -n index.html "index.html.bak.$(date +%Y%m%d-%H%M%S)" || true

  # Ajoute class antialiased si absente
  if grep -q '<html lang="fr">' index.html; then
    sed -i 's/<html lang="fr">/<html lang="fr" class="antialiased">/' index.html
  fi

  # Preload de l’image si absent
  if ! grep -q 'href="/luxeevents-bg-hero.webp"' index.html; then
    sed -i 's#</head>#  <link rel="preload" as="image" href="/luxeevents-bg-hero.webp" />\n</head>#' index.html
  fi

  # Nettoie un éventuel token "falsenavigator"
  sed -i 's/falsenavigator/navigator/g' index.html

  echo "• index.html ajusté (antialiased + preload + clean token)."
fi

# 4) Build local pour vérifier
echo "• Build…"
pnpm build

# 5) Commit + push
git add -A
git commit -m "v2.5 finalize: normalize services import via wrapper + hero in public + preload" || true
git push origin "$BRANCH"

echo "== Terminé. Ouvre la Preview Vercel de la PR et vérifie la console. =="
