#!/bin/bash

set -e

echo "🧠 [1/6] Détection du fichier CSS principal..."
CSS_FILE=$(find src -name "*.css" | head -n1)

if [ ! -f "$CSS_FILE" ]; then
  echo "❌ Aucun fichier CSS trouvé dans src/"
  exit 1
fi

echo "🎨 Fichier CSS détecté : $CSS_FILE"

if ! grep -q ".text-gold" "$CSS_FILE"; then
  echo "✨ Injection des classes Luxe .text-gold, .bg-gold, .border-gold..."
  sed -i "/^@tailwind utilities;/a\
\n/* === LuxeEvents Custom Classes === */\
.text-gold {\n  color: #f8e9c8;\n}\
\n.bg-gold {\n  background-color: #f8e9c8;\n}\
\n.border-gold {\n  border-color: #f8e9c8;\n}\
\n.hover\\:text-gold:hover {\n  color: #f8e9c8;\n}" "$CSS_FILE"
else
  echo "✅ Classes or déjà présentes, skip."
fi

echo "🔎 [2/6] Ajout SEO page /devis (metadata)..."
mkdir -p src/pages/devis
cat > src/pages/devis/metadata.js <<EOF
export const metadata = {
  title: "Demande de Devis – LuxeEvents",
  description: "Obtenez un devis personnalisé pour votre événement haut de gamme avec LuxeEvents.",
  openGraph: {
    title: "Demande de Devis – LuxeEvents",
    description: "Un événement d'exception commence ici. Contactez-nous pour un devis sur-mesure.",
    url: "https://luxeevents.me/devis",
    type: "website",
    images: [
      {
        url: "/og_devis.jpg",
        width: 1200,
        height: 630,
        alt: "LuxeEvents Devis"
      }
    ]
  }
}
EOF

echo "🌟 [3/6] Vérification favicon..."
cp public/favicon.ico public/favicon.png 2>/dev/null || echo "⚠️ favicon.png manquant, skip."

echo "⚙️ [4/6] Build du projet..."
npm install
npm run build

echo "🚀 [5/6] Déploiement Vercel (production)..."
vercel --prod > deploy-output.txt

LIVE_URL=$(grep -oE 'https://[a-zA-Z0-9.-]+\.vercel\.app' deploy-output.txt | tail -n1)

if [ -z "$LIVE_URL" ]; then
  echo "❌ Échec récupération URL de production."
  exit 1
fi

echo "🌐 [6/6] Site en ligne ici : $LIVE_URL"
echo "🖱️ Ouverture du site dans le navigateur..."

xdg-open "$LIVE_URL" 2>/dev/null || open "$LIVE_URL" || echo "👉 Ouvre manuellement : $LIVE_URL"

echo "✅ Déploiement final terminé ! Que le luxe commence 💎"
