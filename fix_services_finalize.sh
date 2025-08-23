#!/usr/bin/env bash
set -euo pipefail

echo "== Fix Services (wrapper + dedup + build) =="

BRANCH="$(git rev-parse --abbrev-ref HEAD || true)"
echo "• Branche courante: $BRANCH"

# 1) Wrapper unique pour normaliser les exports
mkdir -p src/data
WRAP="src/data/services.luxe.wrap.js"
cat > "$WRAP" <<'JS'
import * as S from './services.luxe.js';
const services = (S && (S.services || S.default || S.luxeServices || S.data)) || [];
export { services };
export default services;
JS
echo "• Wrapper écrit: $WRAP"

# 2) Patch ServicesSection.jsx
COMP="src/components/ServicesSection.jsx"
if [[ ! -f "$COMP" ]]; then
  echo "⚠ ${COMP} introuvable, arrêt."; exit 1
fi
cp -n "$COMP" "$COMP.bak.$(date +%Y%m%d-%H%M%S)" || true

# (a) vire tout import vers services.luxe.js (version brute)
sed -i -E '/import[[:space:]]+\*?[[:space:]]*as[[:space:]]*S[[:space:]]*from[[:space:]]*["'\'']\.\.\/data\/services\.luxe\.js["'\''];?/d' "$COMP"
sed -i -E '/from[[:space:]]*["'\'']\.\.\/data\/services\.luxe\.js["'\''];?/d' "$COMP"

# (b) insère l’import du wrapper si absent
if ! grep -q 'services\.luxe\.wrap\.js' "$COMP"; then
  awk '
    BEGIN{last=0}
    {print; if($0 ~ /^[[:space:]]*import /) last=NR}
  ' "$COMP" > "$COMP.__tmp__"

  awk -v file="$COMP.__tmp__" '
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
    }' > "$COMP"
  rm -f "$COMP.__tmp__"
  echo "• Import wrapper injecté."
else
  echo "• Import wrapper déjà présent."
fi

# (c) supprime toute ancienne ligne const services = S....
sed -i -E '/const[[:space:]]+services[[:space:]]*=[[:space:]]*S\./d' "$COMP"

# (d) remplace toute référence à ServicesData par services
sed -i -E 's/\bServicesData\b/services/g' "$COMP"

# (e) force la ligne qui fabrique SERVICES à une version simple et sûre
#    (si elle existe déjà on remplace ; sinon on n’insère rien)
if grep -qE 'const[[:space:]]+SERVICES[[:space:]]*=' "$COMP"; then
  sed -i -E 's@const[[:space:]]+SERVICES[[:space:]]*=.*@const SERVICES = Array.isArray(services) ? services : [];@' "$COMP"
fi

# 3) Optionnel: on tente de placer le hero dans public/ si on le trouve
mkdir -p public
for p in \
  "./luxeevents-bg-hero.webp" \
  "./src/assets/luxeevents-bg-hero.webp" \
  "./images/luxeevents-bg-hero.webp" \
  "../luxeevents-bg-hero.webp" \
  "../images/luxeevents-bg-hero.webp"
do
  if [[ -f "$p" ]]; then
    cp -f "$p" public/luxeevents-bg-hero.webp && echo "• Copié: $p -> public/luxeevents-bg-hero.webp" && break
  fi
done
if [[ ! -f public/luxeevents-bg-hero.webp ]]; then
  echo "ℹ Hero non trouvé (pas bloquant). Tu pourras poser le vrai fichier dans public/ quand tu l’as."
fi

# 4) Build
pnpm build

# 5) Commit + push
git add "$WRAP" "$COMP"
git commit -m "fix(services): normalize import via wrapper, remove duplicate const and ServicesData" || true
git push origin "$BRANCH"

echo "== OK. Vérifie la Preview Vercel (F12 console). =="
