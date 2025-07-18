#!/bin/bash

echo "🚀 Correction des chemins d'image dans GalleryPreview..."
sed -i 's/demo1.jpg/gallery-1.webp/' src/components/GalleryPreview.jsx
sed -i 's/demo2.jpg/gallery-2.webp/' src/components/GalleryPreview.jsx
sed -i 's/demo3.jpg/gallery-3.webp/' src/components/GalleryPreview.jsx
sed -i 's/demo4.jpg/gallery-4.webp/' src/components/GalleryPreview.jsx
sed -i 's/demo5.jpg/gallery-5.webp/' src/components/GalleryPreview.jsx
sed -i 's/demo6.jpg/gallery-6.webp/' src/components/GalleryPreview.jsx

echo "🎯 Mise à jour des ancres dans NavBarLuxe..."
sed -i 's#<Link to="/media">#<a href="#gallery">#' src/components/NavBarLuxe.jsx
sed -i 's#<Link to="/services">#<a href="#services">#' src/components/NavBarLuxe.jsx
sed -i 's#<Link to="/quote">#<a href="#quote">#' src/components/NavBarLuxe.jsx
sed -i 's#</Link>#</a>#g' src/components/NavBarLuxe.jsx

echo "🧠 Insertion SEO dans HomePage.jsx..."
grep -q "react-helmet" src/pages/HomePage.jsx || sed -i '1i import { Helmet } from "react-helmet";' src/pages/HomePage.jsx
sed -i '/<Layout>/i \ \ \ \ <Helmet>\n \ \ \ \ \ \ <title>LuxeEvents – Événements haut de gamme à Bruxelles</title>\n \ \ \ \ \ \ <meta name="description" content="Organisation d’événements élégants à Bruxelles – mariages, soirées, corporate. Devis gratuit." />\n \ \ \ \ \ \ <meta property="og:title" content="LuxeEvents – Le luxe à la portée de tous" />\n \ \ \ \ \ \ <meta property="og:image" content="/media/images/luxeevents-bg-hero.webp" />\n \ \ \ \ </Helmet>' src/pages/HomePage.jsx

echo "🔗 Ajout du favicon dans index.html..."
sed -i '/<head>/a\ \ \ \ <link rel="icon" href="/favicon.ico" />' index.html

echo "✅ Terminé. Tu peux maintenant commit + deploy !"
