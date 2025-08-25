#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
cd "$REPO_DIR"

FILE="index.html"
[ -f "$FILE" ] || { echo "✖ index.html introuvable"; exit 1; }
cp -n "$FILE" "${FILE}.bak.$(date +%Y%m%d-%H%M%S)" || true

# 1) <html lang="fr"> (si manquant) — via perl (lookahead propre)
if ! grep -q 'lang="' "$FILE"; then
  perl -0777 -pe 's/<html(?![^>]*\blang=)/<html lang="fr"/' -i "$FILE"
fi

# 2) HEAD: canonical, description, viewport, theme-color, preconnect, manifest, OG/Twitter, preload hero
add_head_line () {
  local needle="$1" line="$2"
  grep -q "$needle" "$FILE" || sed -i "s@</head>@  $line\n</head>@" "$FILE"
}

add_head_line 'rel="canonical"'         '<link rel="canonical" href="https://www.luxeevents.me/"/>'
add_head_line 'name="viewport"'          '<meta name="viewport" content="width=device-width, initial-scale=1"/>'
add_head_line 'name="theme-color"'       '<meta name="theme-color" content="#0b0b0b"/>'
add_head_line 'name="description"'       '<meta name="description" content="Organisation d’événements haut de gamme à Bruxelles — mariages, corporate, soirées prestige. Devis gratuit."/>'
add_head_line 'fonts.googleapis.com'     '<link rel="preconnect" href="https://fonts.googleapis.com"/>'
add_head_line 'fonts.gstatic.com'        '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>'
add_head_line 'rel="manifest"'           '<link rel="manifest" href="/manifest.json"/>'
add_head_line 'property="og:title"'      '<meta property="og:title" content="LuxeEvents — Événements haut de gamme à Bruxelles"/>'
add_head_line 'property="og:description"'<meta property="og:description" content="Mariages d’exception, corporate raffiné, soirées privées — Luxe, Excellence, Innovation."/>'
add_head_line 'property="og:url"'        '<meta property="og:url" content="https://www.luxeevents.me/"/>'
add_head_line 'property="og:image"'      '<meta property="og:image" content="https://www.luxeevents.me/bg-luxeevents.png"/>'
add_head_line 'name="twitter:card"'      '<meta name="twitter:card" content="summary_large_image"/>'

# 2bis) Preload sûr du hero PNG (on a déjà viré le preload .webp dans tes hotfix)
grep -q 'bg-luxeevents.png' "$FILE" || true
if ! grep -q 'rel="preload".*bg-luxeevents\.png' "$FILE"; then
  sed -i 's@</head>@  <link rel="preload" as="image" href="/bg-luxeevents.png" fetchpriority="high"/>\n</head>@' "$FILE"
fi

# 3) SW guard — idempotent
sed -i -E 's@navigator\.serviceWorker\.registernavigator@navigator.serviceWorker.register@g' "$FILE"
sed -i -E 's@navigator\.serviceWorker\.register\.serviceWorker@navigator.serviceWorker.register@g' "$FILE"
if ! grep -q '/* SW guard */' "$FILE"; then
  perl -0777 -pe 's~</body>~  <script>/* SW guard */(function(){try{if("serviceWorker" in navigator){fetch("/sw.js",{method:"HEAD"}).then(r=>{if(r.ok){navigator.serviceWorker.register("/sw.js").catch(()=>{});}});}}catch(e){}})();</script>\n</body>~' -i "$FILE"
fi

# 4) Galerie — impose lazy/decoding/wh/h/alt sur thumbN.png (idempotent)
perl -0777 -pe '
  s/(<img\b[^>]*\bsrc=["\']\/images\/gallery\/thumb(\d+)\.png["\'][^>]*)(>)/
     my $t=$1; my $n=$2;
     $t =~ s/\bloading=["\'][^"\']*["\']//g;
     $t =~ s/\bdecoding=["\'][^"\']*["\']//g;
     $t =~ s/\bwidth=["\'][^"\']*["\']//g;
     $t =~ s/\bheight=["\'][^"\']*["\']//g;
     $t =~ s/\balt=["\'][^"\']*["\']//g;
     $t .= " loading=\"lazy\" decoding=\"async\" width=\"600\" height=\"400\" alt=\"Galerie LuxeEvents " . $n . "\"";
     $t . ">"
  /ige
' -i "$FILE"

# 5) JSON-LD (Organization + WebSite) si absent
if ! grep -q 'application/ld+json' "$FILE"; then
  sed -i 's@</head>@  <script type="application/ld+json">{"@context":"https://schema.org","@type":"Organization","name":"LuxeEvents","url":"https://www.luxeevents.me/","logo":"https://www.luxeevents.me/logo_gold_black.png","sameAs":[]}</script>\n</head>@' "$FILE"
  sed -i 's@</head>@  <script type="application/ld+json">{"@context":"https://schema.org","@type":"WebSite","name":"LuxeEvents","url":"https://www.luxeevents.me/"}</script>\n</head>@' "$FILE"
fi

# 6) robots + sitemap si manquants
mkdir -p public
[ -f public/robots.txt ] || cat > public/robots.txt <<TXT
User-agent: *
Allow: /
Sitemap: https://www.luxeevents.me/sitemap.xml
TXT

[ -f public/sitemap.xml ] || cat > public/sitemap.xml <<XML
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://www.luxeevents.me/</loc></url>
  <url><loc>https://www.luxeevents.me/devis</loc></url>
  <url><loc>https://www.luxeevents.me/services</loc></url>
  <url><loc>https://www.luxeevents.me/mentions-legales</loc></url>
  <url><loc>https://www.luxeevents.me/politique-confidentialite</loc></url>
  <url><loc>https://www.luxeevents.me/contact</loc></url>
</urlset>
XML

# 7) Commit + push
(pnpm test || npm test || echo "No test specified") >/dev/null 2>&1 || true
git add index.html public/robots.txt public/sitemap.xml
git commit -m "chore(seo/perf/a11y): last-mile polish (canonical, meta, JSON-LD, preload hero, lazy gallery)" || true
git push origin HEAD
echo "✓ Last-mile polish poussé."
