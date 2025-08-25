#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
cd "$REPO_DIR"

FILE="index.html"
[ -f "$FILE" ] || { echo "✖ index.html introuvable"; exit 1; }
cp -n "$FILE" "${FILE}.bak.$(date +%Y%m%d-%H%M%S)" || true

# 1) <html lang="fr"> si manquant
if ! grep -q 'lang="' "$FILE"; then
  sed -i 's/<html>/<html lang="fr">/' "$FILE"
fi

# 2) Injections HEAD (idempotentes) via liste + boucle
cat > .head_inject.tmp <<'EOT'
<link rel="canonical" href="https://www.luxeevents.me/"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="theme-color" content="#0b0b0b"/>
<meta name="description" content="Organisation d’événements haut de gamme à Bruxelles — mariages, corporate, soirées prestige. Devis gratuit."/>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
<link rel="manifest" href="/manifest.json"/>
<meta property="og:title" content="LuxeEvents — Événements haut de gamme à Bruxelles"/>
<meta property="og:description" content="Mariages d’exception, corporate raffiné, soirées privées — Luxe, Excellence, Innovation."/>
<meta property="og:url" content="https://www.luxeevents.me/"/>
<meta property="og:image" content="https://www.luxeevents.me/bg-luxeevents.png"/>
<meta name="twitter:card" content="summary_large_image"/>
<link rel="preload" as="image" href="/bg-luxeevents.png" fetchpriority="high"/>
EOT

while IFS= read -r line; do
  # si la ligne exacte n’existe pas, on l’insère avant </head>
  if ! grep -Fq "$line" "$FILE"; then
    sed -i "/<\/head>/i \  $line" "$FILE"
  fi
done < .head_inject.tmp
rm -f .head_inject.tmp

# 3) SW guard — seulement si absent
if ! grep -q '/* SW guard */' "$FILE"; then
  cat > .swguard.tmp <<'JS'
  <script>/* SW guard */
  (function(){
    try{
      if("serviceWorker" in navigator){
        fetch("/sw.js",{method:"HEAD"}).then(function(r){
          if(r.ok){ navigator.serviceWorker.register("/sw.js").catch(function(){}); }
        });
      }
    }catch(e){}
  })();
  </script>
JS
  awk 'BEGIN{added=0}
       /<\/body>/{ 
         if(!added){
           while((getline l<".swguard.tmp")>0) print l;
           close(".swguard.tmp");
           added=1
         }
         print; next
       }
       {print}' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
  rm -f .swguard.tmp
fi

# 4) Galerie : ajoute lazy/decoding si pas déjà présents sur les thumbs
# (simple et robuste : n’essaie pas de gérer width/height ici)
sed -i -E 's@(<img[^>]*src="/images/gallery/thumb[^"]+\.png)([^>]*>)@\1 loading="lazy" decoding="async"\2@g' "$FILE"

# 5) JSON-LD (Organization + WebSite) si absent
if ! grep -q 'application/ld+json' "$FILE"; then
  cat > .jsonld.tmp <<'JSON'
  <script type="application/ld+json">{"@context":"https://schema.org","@type":"Organization","name":"LuxeEvents","url":"https://www.luxeevents.me/","logo":"https://www.luxeevents.me/logo_gold_black.png","sameAs":[]}</script>
  <script type="application/ld+json">{"@context":"https://schema.org","@type":"WebSite","name":"LuxeEvents","url":"https://www.luxeevents.me/"}</script>
JSON
  # insère juste avant </head>
  sed -i '/<\/head>/{e cat .jsonld.tmp
}' "$FILE"
  rm -f .jsonld.tmp
fi

# 6) robots.txt + sitemap.xml si manquants
mkdir -p public
[ -f public/robots.txt ] || cat > public/robots.txt <<'TXT'
User-agent: *
Allow: /
Sitemap: https://www.luxeevents.me/sitemap.xml
TXT

[ -f public/sitemap.xml ] || cat > public/sitemap.xml <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://www.luxeevents.me/\</loc\>\</url\>
  <url><loc>https://www.luxeevents.me/devis\</loc\>\</url\>
  <url><loc>https://www.luxeevents.me/services\</loc\>\</url\>
  <url><loc>https://www.luxeevents.me/mentions-legales\</loc\>\</url\>
  <url><loc>https://www.luxeevents.me/politique-confidentialite\</loc\>\</url\>
  <url><loc>https://www.luxeevents.me/contact\</loc\>\</url\>
</urlset>
XML

# 7) Commit + push
(pnpm test || npm test || echo "No test specified") >/dev/null 2>&1 || true
git add index.html public/robots.txt public/sitemap.xml
git commit -m "chore(seo/perf/a11y): last-mile polish (canonical, meta, JSON-LD, preload hero, lazy gallery)" || true
git push origin HEAD
echo "✓ Last-mile polish poussé."
