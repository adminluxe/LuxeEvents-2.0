#!/bin/bash
echo '🧼 Nettoyage des blocs Helmet existants...'
find src/pages -type f -name "*.jsx" -exec sed -i '/<Helmet>/,/<\/Helmet>/d' {} \;

echo '✨ Réinjection des Helmet SEO page par page...'
echo 'Injecting into src/pages/HomePage.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Sublimez votre événement</title>\\\n        <meta name=\"description\" content=\"Page d'accueil immersive de LuxeEvents – Événements haut de gamme.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Sublimez votre événement\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/HomePage.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/HomePage.jsx

echo 'Injecting into src/pages/mariage.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Mariages de Prestige</title>\\\n        <meta name=\"description\" content=\"Vivez le mariage de vos rêves avec LuxeEvents, dans un univers de luxe et d’émotion.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Mariages de Prestige\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/mariage.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/mariage.jsx

echo 'Injecting into src/pages/corporate.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Événements d’entreprise haut de gamme</title>\\\n        <meta name=\"description\" content=\"Séminaires, galas, lancements : impressionnez vos clients avec une organisation irréprochable.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Événements d’entreprise haut de gamme\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/corporate.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/corporate.jsx

echo 'Injecting into src/pages/culturel.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Événements culturels d’exception</title>\\\n        <meta name=\"description\" content=\"Sublimez l’art, la mode ou le patrimoine grâce à une mise en scène innovante et immersive.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Événements culturels d’exception\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/culturel.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/culturel.jsx

echo 'Injecting into src/pages/devis.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Demandez votre devis personnalisé</title>\\\n        <meta name=\"description\" content=\"Un événement sur-mesure commence ici. Demandez votre devis gratuitement.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Demandez votre devis personnalisé\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/devis.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/devis.jsx

echo 'Injecting into src/pages/RequestQuotePage.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Formulaire de demande de devis</title>\\\n        <meta name=\"description\" content=\"Remplissez notre formulaire et recevez une proposition personnalisée pour votre événement.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Formulaire de demande de devis\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/RequestQuotePage.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/RequestQuotePage.jsx

echo 'Injecting into src/pages/Legal.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Mentions légales & RGPD</title>\\\n        <meta name=\"description\" content=\"Toutes les mentions légales concernant l’utilisation du site LuxeEvents.me.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Mentions légales & RGPD\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/Legal.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/Legal.jsx

echo 'Injecting into src/pages/MediaPage.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Galerie photos et vidéos</title>\\\n        <meta name=\"description\" content=\"Plongez dans l’univers visuel de LuxeEvents à travers nos plus beaux événements.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Galerie photos et vidéos\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/MediaPage.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/MediaPage.jsx

echo 'Injecting into src/pages/ServicesPage.jsx...'
sed -i '/return (/a\
    <>\\\n      <Helmet>\\\n        <title>LuxeEvents – Nos services d’exception</title>\\\n        <meta name=\"description\" content=\"Découvrez nos prestations sur-mesure pour faire de votre événement une réussite.\" />\\\n        <meta property=\"og:title\" content=\"LuxeEvents – Nos services d’exception\" />\\\n        <meta property=\"og:image\" content=\"/og_default.jpg\" />\\\n      </Helmet>' src/pages/ServicesPage.jsx
sed -i '/<\/[^>]*>;/i\    </>' src/pages/ServicesPage.jsx
