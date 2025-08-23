#!/usr/bin/env bash
set -euo pipefail

echo "== Fix ServicesSection (dedup + wrapper + block replace) =="

COMP="src/components/ServicesSection.jsx"
WRAP="src/data/services.luxe.wrap.js"

[[ -f "$COMP" ]] || { echo "❌ Introuvable: $COMP"; exit 1; }

# 1) Wrapper normalisateur d’exports (default / named)
mkdir -p "$(dirname "$WRAP")"
cat > "$WRAP" <<'JS'
import * as S from './services.luxe.js';
const services =
  (S && (S.services || S.default || S.luxeServices || S.data)) || [];
export { services };
export default services;
JS
echo "• Wrapper écrit: $WRAP"

# 2) Sauvegarde du composant
cp -n "$COMP" "$COMP.bak.$(date +%Y%m%d-%H%M%S)" || true

# 3) Nettoyage des anciens imports/services bruts
sed -i -E '/from[[:space:]]*["'\'']\.\.\/data\/services\.luxe\.js["'\''];?/d' "$COMP"
sed -i -E '/const[[:space:]]+services[[:space:]]*=[[:space:]]*S\./d' "$COMP"
sed -i -E 's/\bServicesData\b/services/g' "$COMP"

# 4) Injection de l’import wrapper + const services (si absent)
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
          print "const services = (servicesNamed ?? servicesDefault) ?? [];"
        }
      }
    }' > "$COMP"
  rm -f "$COMP.__tmp__"
  echo "• Import wrapper injecté."
else
  # S’assure que la const services est bien là (sinon, on l’ajoute après l’import wrapper)
  if ! grep -qE 'const[[:space:]]+services[[:space:]]*=' "$COMP"; then
    sed -i -E 's@(import .*services\.luxe\.wrap\.js";)@\1\nconst services = (servicesNamed ?? servicesDefault) ?? [];@' "$COMP"
  fi
  echo "• Import wrapper déjà présent."
fi

# 5) Remplacement SÛR du bloc "const SERVICES = ..." (multi-lignes ok)
#    -> on remplace TOUTE la déclaration (jusqu’au premier ';') par une seule ligne simple
awk '
  BEGIN{state=0}
  {
    if(state==0){
      if($0 ~ /const[[:space:]]+SERVICES[[:space:]]*=/){
        print "const SERVICES = Array.isArray(services) ? services : [];"
        state=1
      } else {
        print
      }
    } else {
      # on saute jusqu’au premier ';' qui termine l’ancienne déclaration
      if($0 ~ /;/){ state=0 }
      # (on NE print RIEN pendant le skip)
    }
  }
' "$COMP" > "$COMP.__fix__" && mv "$COMP.__fix__" "$COMP"

# 6) Petit nettoyage: si des débris de ternaires sont restés, on les enlève
#    (lignes orphelines qui commencent par '?' ou ':' juste après notre remplacement)
sed -i -E 's/^[[:space:]]*[?:][^;]*;?[[:space:]]*$//g' "$COMP"

# 7) (Facultatif) déposer le hero si tu l’as quelque part (sinon c’est pas bloquant)
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
[[ -f public/luxeevents-bg-hero.webp ]] || echo "ℹ Hero non trouvé (pas bloquant)."

# 8) Build + commit + push
pnpm build
git add "$WRAP" "$COMP"
git commit -m "fix(services): replace broken SERVICES block; unify via wrapper" || true
git push

echo "== OK. Vérifie la Preview Vercel (console F12). =="
