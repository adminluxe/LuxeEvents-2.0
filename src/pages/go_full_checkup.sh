#!/bin/bash

echo "🚀 [LuxeEvents] Full Checkup Immersif en cours..."
cd "$(dirname "$0")/../"

echo "📁 Forçage racine projet: $(pwd)"

# Crée le dossier public s'il n'existe pas
mkdir -p public

# 1. Mise à jour du manifest
echo "📦 Mise à jour du manifest.json"
cat << JSON > public/manifest.json
{
  "short_name": "LuxeEvents",
  "name": "LuxeEvents – Sublimez votre événement",
  "icons": [
    {
      "src": "logo192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "logo512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ],
  "start_url": "/",
  "scope": "/",
  "display": "standalone",
  "theme_color": "#000000",
  "background_color": "#0e0c0c",
  "orientation": "portrait"
}
JSON
echo "✅ Manifest.json mis à jour"

# 2. robots.txt
echo "🧠 Check robots.txt"
echo "User-agent: *" > public/robots.txt
echo "Allow: /" >> public/robots.txt
echo "✅ Robots.txt prêt"

# 3. Sitemap
echo "🌐 Génération sitemap.xml (exemple de base)"
cat << XML > public/sitemap.xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://luxeevents.me/\</loc\>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
XML
echo "✅ Sitemap.xml généré"

# 4. Lighthouse
echo "🧪 Lance Lighthouse dans Chrome (manuel)..."
echo "👉 Chrome DevTools > Lighthouse > Run Audit"
echo "    ou npx lighthouse https://luxeevents.me --view"

# 5. Analytics
echo "📈 Vérifie GA4 & Smartlook live..."

# 6. Vercel
if command -v vercel &> /dev/null
then
    echo "🚀 Déploiement Vercel en cours..."
    vercel --prod
else
    echo "⚠️ Vercel CLI non trouvé. Lance : npm i -g vercel"
fi

echo "🎯 Full Checkup terminé. Connecte Search Console pour indexation !"
