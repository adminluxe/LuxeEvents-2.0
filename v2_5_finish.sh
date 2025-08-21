#!/usr/bin/env bash
set -euo pipefail

echo "== LuxeEvents V2.5 – Polish final =="

# 0) garde-fous
[[ -f package.json ]] || { echo "❌ Lance ce script à la racine du projet"; exit 1; }
[[ -f index.html ]] || { echo "❌ index.html introuvable"; exit 1; }

# 1) CSS : vire la propriété bruyante pour Firefox
echo "• CSS cleanup: -moz-osx-font-smoothing"
FOUND=$(grep -RIl --include='*.css' '\-moz-osx-font-smoothing' src 2>/dev/null || true)
if [[ -n "${FOUND}" ]]; then
  echo "$FOUND" | while read -r f; do
    sed -i.bak '/-moz-osx-font-smoothing/d' "$f"
  done
  echo "  ↳ supprimée des CSS."
else
  echo "  ↳ rien à retirer."
fi

# 2) index.html : métas et H1 SEO
echo "• Mise à jour index.html (title, OG locale/desc, H1 SEO)"
# Title
sed -i.bak -E 's#<title>.*</title>#<title>LuxeEvents — Le Luxe à la portée de tous… Pour des expériences inoubliables !</title>#' index.html

# OG locale -> fr_FR
sed -i.bak -E 's/(property="og:locale"\s+content=")[^"]+(")/\1fr_FR\2/' index.html

# OG description + twitter description (texte plus neutre, sans Belgique)
NEW_DESC='LuxeEvents propose des événements premium — luxe, excellence, innovation. Devis rapide, accompagnement rassurant, expériences inoubliables.'
sed -i.bak -E "s#(<meta[^>]+property=\"og:description\"[^>]+content=\")[^\"]*(\"[^>]*>)#\1${NEW_DESC}\2#" index.html
sed -i.bak -E "s#(<meta[^>]+name=\"twitter:description\"[^>]+content=\")[^\"]*(\"[^>]*>)#\1${NEW_DESC}\2#" index.html

# H1 SEO (caché)
H1TXT='Le Luxe à la portée de tous… Pour des expériences inoubliables !'
perl -0777 -pe "s#(<h1>).*?(</h1>)#\${1}${H1TXT}\${2}#gs" -i.bak index.html

# 3) JSON-LD Organization : adresse Paris + neutralité
echo "• JSON-LD Organization (Paris, FR + neutralité)"
node - <<'NODE'
const fs=require('fs');
let html=fs.readFileSync('index.html','utf8');

function patchJsonLd(html, type, mutator){
  return html.replace(
    new RegExp(`<script\\s+type="application/ld\\+json">([\\s\\S]*?)</script>`, 'g'),
    (m, json) => {
      try{
        const data=JSON.parse(json.trim());
        if(data['@type']===type){
          mutator(data);
          return `<script type="application/ld+json">${JSON.stringify(data)}</script>`;
        }
        return m;
      }catch(e){ return m; }
    }
  );
}

html = patchJsonLd(html, 'Organization', (org) => {
  org.name = 'LuxeEvents';
  org.url = 'https://luxeevents.me/';
  org.logo = org.logo || 'https://luxeevents.me/images/og-luxeevents.jpg';
  org.email = 'contact@luxeevents.me';
  // Adresse Paris, France
  org.address = {
    "@type": "PostalAddress",
    "addressLocality": "Paris",
    "addressCountry": "FR"
  };
  // Service global
  org.areaServed = "Worldwide";
  // Nettoyage éventuelles mentions Belgique dans description
  if (org.description && /Belgique/i.test(org.description)) {
    org.description = org.description.replace(/Belgique/ig, '').replace(/\s{2,}/g,' ').trim();
  }
});
fs.writeFileSync('index.html', html);
console.log('  ↳ JSON-LD Organization mis à jour.');
NODE

# 4) Preload hero (au cas où)
echo "• Vérif preload héro"
if ! grep -q 'luxeevents-bg-hero.webp' index.html; then
  sed -i.bak 's#</head>#  <link rel="preload" as="image" href="/luxeevents-bg-hero.webp" fetchpriority="high" />\n</head>#' index.html
  echo "  ↳ preload ajouté."
else
  echo "  ↳ preload déjà présent."
fi

echo "== OK. Pense à recharger fort (Ctrl+F5) =="
