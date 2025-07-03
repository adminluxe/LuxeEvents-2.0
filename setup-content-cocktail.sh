#!/usr/bin/env bash
set -euo pipefail

echo "🍹 Démarrage du Content Cocktail à la Tonton…"

# 1) Copy Landing Coming Soon
echo "1) Génération de la copie Landing (src/content/landing.md)…"
mkdir -p src/content
cat > src/content/landing.md << 'EOF'
# Titre accrocheur
« LuxeEvents débarque sous peu… »

## Sous-titre poétique
« Un univers où chaque instant devient légende, lancement dans 7 jours. »
EOF

# 2) Templates Drip Emails
echo "2) Création des templates d’emails (scripts/emails)…"
mkdir -p scripts/emails/templates
for delay in J0 J3 J7; do
  cat > scripts/emails/templates/email_${delay}.md << 'EOF'
# Email ${delay}

Objet :  
[À remplir] – une ligne qui accroche comme un vers.

Corps du message :  
  
Chère âme aventurière,  
…  
**À suivre** → tease du prochain email.
EOF
done

# 3) Accroches Ads
echo "3) Scaffolding Ads (src/content/ads)…"
mkdir -p src/content/ads
cat > src/content/ads/google_ads.md << 'EOF'
# Google Ads

- Titre 1 : LuxeEvents – L’art de vos instants  
- Titre 2 : Préventes ouvertes bientôt  
- Description : Vivez l’inédit, réservez votre place pour le lancement.  
EOF

cat > src/content/ads/linkedin_ads.md << 'EOF'
# LinkedIn Ads

- Accroche courte : Quand l’exception devient rendez-vous.  
- Description : Rejoignez la pré-liste et soyez les premiers servis.  
EOF

# 4) Snippet Retargeting
echo "4) Création du snippet retargeting (src/utils/pixelCleanup.js)…"
mkdir -p src/utils
cat > src/utils/pixelCleanup.js << 'EOF'
// src/utils/pixelCleanup.js
export function resetPixels() {
  // Ici tu pourras purge et ré-installer tes pixels FB/LinkedIn
  console.log("Pixels purgés, prêt pour le retargeting.");
}
EOF

# 5) Plan Dashboard KPI
echo "5) Plan et schema du dashboard (scripts/dashboard)…"
mkdir -p scripts/dashboard
cat > scripts/dashboard/schema.md << 'EOF'
# Dashboard KPI

## Métriques clés
- Inscriptions teaser  
- Taux d’ouverture (emails J0/J3/J7)  
- CTR Google Ads & LinkedIn  
- Conversions préventes  
EOF

cat > scripts/dashboard/dashboard.js << 'EOF'
// scripts/dashboard/dashboard.js
// À enrichir : collecte via GA4 & injection en BigQuery/Notion
console.log("🚀 Dashboard CLI prêt pour récupérer tes KPIs.");
EOF

echo "✅ Content Cocktail prêt ! 🎉"
echo "→ Pense à remplir les placeholders et à customiser chaque fichier."
