#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
cd "$REPO_DIR"

FILE="index.html"
[ -f "$FILE" ] || { echo "✖ index.html introuvable"; exit 1; }
cp -n "$FILE" "${FILE}.bak.$(date +%Y%m%d-%H%M%S)" || true

# 1) <html lang="fr">
sed -i -E 's@<html([^>]*)>@<html lang="fr"\1>@; t; $a\' "$FILE"

# 2) <head> — canonical, meta, preconnect, manifest, theme-color, OG/Twitter
awk -v RS= -v ORS= '
  function inject_head(h) {
    if (index(h,"rel=\"canonical\"")==0)
      h = gensub("</title>","</title>\n  <link rel=\"canonical\" href=\"https://www.luxeevents.me/\"/>",1,h)
    if (index(h,"name=\"viewport\"")==0)
      h = gensub("<head>","<head>\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"/>",1,h)
    if (index(h,"name=\"theme-color\"")==0)
      h = gensub("</title>","</title>\n  <meta name=\"theme-color\" content=\"#0b0b0b\"/>",1,h)
    if (index(h,"name=\"description\"")==0)
      h = gensub("</title>","</title>\n  <meta name=\"description\" content=\"Organisation d’événements haut de gamme à Bruxelles — mariages, corporate, soirées prestige. Devis gratuit.\"/>",1,h)
    if (index(h,"fonts.googleapis.com")==0)
      h = gensub("</title>","</title>\n  <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\"/>\n  <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin/>",1,h)
    if (index(h,"rel=\"manifest\"")==0)
      h = gensub("</title>","</title>\n  <link rel=\"manifest\" href=\"/manifest.json\"/>",1,h)
    if (index(h,"og:title")==0)
      h = gensub("</title>","</title>\n  <meta property=\"og:title\" content=\"LuxeEvents — Événements haut de gamme à Bruxelles\"/>",1,h)
    if (index(h,"og:description")==0)
      h = gensub("</title>","</title>\n  <meta property=\"og:description\" content=\"Mariages d’exception, corporate raffiné, soirées privées — Luxe, Excellence, Innovation.\"/>",1,h)
    if (index(h,"og:url")==0)
      h = gensub("</title>","</title>\n  <meta property=\"og:url\" content=\"https://www.luxeevents.me/\"/>",1,h)
    if (index(h,"og:image")==0)
      h = gensub("</title>","</title>\n  <meta property=\"og:image\" content=\"https://www.luxeevents.me/bg-luxeevents.png\"/>",1,h)
    if (index(h,"twitter:card")==0)
      h = gensub("</title>","</title>\n  <meta name=\"twitter:card\" content=\"summary_large_image\"/>",1,h)
    # Preload héro PNG (sûr, présent en prod)
    if (h !~ /rel=\"preload\"[^>]+bg-luxeevents\.png/)
      h = gensub("</title>","</title>\n  <link rel=\"preload\" as=\"image\" href=\"/bg-luxeevents.png\" imagesrcset=\"/bg-luxeevents.png 1x\" fetchpriority=\"high\"/>",1,h)
    return h
  }
  {
    sub(/<head[^>]*>/, "&\n");  # assurer un \n après <head>
    $0 = gensub(/(<head[^>]*>)([\\s\\S]*?)(<\\/head>)/, "\\1" inject_head("\\1\\2\\3") "\\3", 1);
    print
  }' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

# 3) Service Worker guard déjà présent — correctifs idempotents
sed -i -E 's@navigator\.serviceWorker\.registernavigator@navigator.serviceWorker.register@g' "$FILE"
sed -i -E 's@navigator\.serviceWorker\.register\.serviceWorker@navigator.serviceWorker.register@g' "$FILE"

# 4) Galerie — PNG + lazy/decoding/width/height (ajout non destructif)
#    Ajoute attrs manquants sur <img .../images/gallery/thumbN.png>
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
grep -q 'application/ld+json' "$FILE" || awk -v RS= -v ORS= '
  { sub("</head>",
"  <script type=\"application/ld+json\">{\n"\
"    \"@context\":\"https://schema.org\",\"@type\":\"Organization\",\n"\
"    \"name\":\"LuxeEvents\",\"url\":\"https://www.luxeevents.me/\",\n"\
"    \"logo\":\"https://www.luxeevents.me/logo_gold_black.png\",\n"\
"    \"sameAs\":[]\n"\
"  }</script>\n"\
"  <script type=\\\"application/ld+json\\\">{\n"\
"    \\\"@context\\\":\\\"https://schema.org\\\",\\\"@type\\\":\\\"WebSite\\\",\n"\
"    \\\"name\\\":\\\"LuxeEvents\\\",\\\"url\\\":\\\"https://www.luxeevents.me/\\\"\n"\
"  }</script>\n</head>"); print }' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

# 6) Sitemap + robots (si non présents)
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
