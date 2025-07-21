#!/bin/bash

echo "🔍 Vérification des balises SEO dans layout.tsx"

TARGET="src/app/layout.tsx"

grep -q '<title>' "$TARGET" || echo "⚠️  Pas de balise <title> trouvée"
grep -q 'name="description"' "$TARGET" || echo "⚠️  Pas de meta description trouvée"
grep -q 'og:title' "$TARGET" || echo "⚠️  Pas de balise og:title"
grep -q 'twitter:card' "$TARGET" || echo "⚠️  Pas de balise twitter:card"

echo "✅ Vérification terminée"
