#!/bin/bash
echo "🔧 Correction HeroSection.css sans @apply..."
cat <<'CSS' > src/components/HeroSection.css
$(tail -n +2 src/components/HeroSection.css | grep -v '@apply')
CSS
echo "✅ Correction appliquée. Relance ton dev server!"
