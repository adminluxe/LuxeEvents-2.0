#!/bin/bash
echo "🔧 Vérification des traductions 'services'…"

FILES=(
  "public/locales/fr/fr.json"
  "public/locales/en/en.json"
)

for file in "${FILES[@]}"; do
  if [[ "$file" == *"fr.json" ]]; then
    title="Nos services"
    cta="Pour un devis personnalisé, contactez-nous sans attendre."
  else
    title="Our Services"
    cta="For a personalized quote, contact us now."
  fi

  if jq -e '.services' "$file" > /dev/null; then
    echo "✅ Bloc 'services' déjà présent dans $file"
  else
    echo "➕ Ajout du bloc 'services' dans $file"
    jq --arg title "$title" --arg cta "$cta" '. + {services: {title: $title, cta: $cta}}' "$file" > tmp.$$.json && mv tmp.$$.json "$file"
  fi
done

echo "✅ Traductions mises à jour."
