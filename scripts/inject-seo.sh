#!/bin/bash

echo "💎 Injection SEO & Meta pour LuxeEvents (Vite/React)..."

sed -i '/<title>/a\
<meta name="description" content="LuxeEvents – Expérience événementielle immersive et haut de gamme." />\
<meta property="og:title" content="LuxeEvents – Événements haut de gamme" />\
<meta property="og:description" content="Mariage, Corporate, Culturel : vivez le luxe, l’émotion, l’innovation." />\
<meta property="og:image" content="/og_default.jpg" />\
<meta property="og:url" content="https://luxeevents.me" />\
<meta name="twitter:card" content="summary_large_image" />\
<meta name="twitter:title" content="LuxeEvents – Événements haut de gamme" />\
<meta name="twitter:description" content="Mariage, Corporate, Culturel : vivez le luxe, l’émotion, l’innovation." />\
<meta name="twitter:image" content="/og_default.jpg"' public/index.html

sed -i 's|<title>.*</title>|<title>LuxeEvents – Sublimez votre événement</title>|' public/index.html

echo "✅ SEO LuxeEvents injecté avec succès dans public/index.html"
