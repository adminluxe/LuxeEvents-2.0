#!/usr/bin/env bash
set -euo pipefail

COMP="src/components/ServicesSection.jsx"
WRAP="src/data/services.luxe.wrap.js"

echo "== Fix ServicesSection via Node =="

[[ -f "$COMP" ]] || { echo "❌ Introuvable: $COMP"; exit 1; }

# 1) Wrapper normalisateur (default / named)
mkdir -p "$(dirname "$WRAP")"
cat > "$WRAP" <<'JS'
import * as S from './services.luxe.js';
const services =
  (S && (S.services || S.default || S.luxeServices || S.data)) || [];
export { services };
export default services;
JS
echo "• Wrapper ok: $WRAP"

# 2) Patch du composant avec Node (remplacements robustes)
node - <<'NODE'
const fs = require('fs');
const comp = 'src/components/ServicesSection.jsx';
let s = fs.readFileSync(comp, 'utf8');

// a) virer tout ancien import direct du fichier "services.luxe.js"
s = s.replace(/^[^\n]*from\s+["']\.\.\/data\/services\.luxe\.js["'];?\s*\n/gm, '');

// b) s'assurer qu'on importe le wrapper
if (!/services\.luxe\.wrap\.js/.test(s)) {
  // on insère après le dernier import
  const imports = [...s.matchAll(/^import .*;[ \t]*$/gm)];
  if (imports.length) {
    const last = imports[imports.length - 1];
    const idx = last.index + last[0].length;
    s = s.slice(0, idx) +
        `\nimport servicesDefault, { services as servicesNamed } from "../data/services.luxe.wrap.js";\n` +
        `const services = (servicesNamed ?? servicesDefault) ?? [];\n` +
        s.slice(idx);
  } else {
    s =
      `import servicesDefault, { services as servicesNamed } from "../data/services.luxe.wrap.js";\n` +
      `const services = (servicesNamed ?? servicesDefault) ?? [];\n` + s;
  }
} else {
  // c) si wrapper importé mais sans const services, on l'ajoute juste après l'import wrapper
  if (!/const\s+services\s*=/.test(s)) {
    s = s.replace(
      /(import\s+.*services\.luxe\.wrap\.js["'];\s*)/,
      `$1\nconst services = (servicesNamed ?? servicesDefault) ?? [];\n`
    );
  }
}

// d) remplacer tout "ServicesData" résiduel par "services"
s = s.replace(/\bServicesData\b/g, 'services');

// e) remplacer TOUT le bloc "const SERVICES = ... ;" (multiligne) par une ligne simple
const reBlock = /const\s+SERVICES\s*=[\s\S]*?;/m;
if (reBlock.test(s)) {
  s = s.replace(reBlock, 'const SERVICES = Array.isArray(services) ? services : [];');
} else {
  // si pas trouvé, on l’injecte juste après la déclaration "const services ..."
  s = s.replace(
    /(const\s+services\s*=\s*\(servicesNamed\s*\?\?\s*servicesDefault\)\s*\?\?\s*\[\];?\s*)/,
    `$1\nconst SERVICES = Array.isArray(services) ? services : [];\n`
  );
}

// f) nettoyer d’éventuels vestiges de ternaires orphelins (“?”/“:” au début de ligne)
s = s.replace(/^[ \t]*[?:].*$/gm, '');

// g) sauver
fs.writeFileSync(comp, s);
console.log('• Composant patché:', comp);
NODE

# 3) (optionnel) copier le hero si tu l’as localement
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

# 4) Build + commit + push
pnpm build
git add "$WRAP" "$COMP"
git commit -m "fix(services): normalize import via wrapper + replace broken SERVICES block" || true
git push

echo "== Done. Check Vercel preview. =="
