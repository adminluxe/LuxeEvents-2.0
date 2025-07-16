#!/bin/bash

echo "💠 Restauration de l’intro Lottie pour LuxeEvents..."

# 1. Création du composant Lottie
COMPONENT="src/components/IntroAnimationLottie.jsx"
mkdir -p "$(dirname "$COMPONENT")"
cat <<EOF > "$COMPONENT"
import { useEffect } from 'react';
import '@lottiefiles/lottie-player';

export default function IntroAnimationLottie({ onFinish }) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onFinish();
    }, 3500);
    return () => clearTimeout(timer);
  }, [onFinish]);

  return (
    <div className="fixed inset-0 z-50 bg-ivory flex items-center justify-center">
      <lottie-player
        src="/lottie/luxeevents.json"
        background="transparent"
        speed="1"
        autoplay
        style={{ width: '100%', maxWidth: '420px', height: 'auto' }}
      ></lottie-player>
    </div>
  );
}
EOF

# 2. Ajout du fichier Lottie (placeholder ici)
mkdir -p public/lottie
echo '{ "v": "5.7.4", "fr": 30, "ip": 0, "op": 60, "w": 500, "h": 500, "nm": "luxeevents-placeholder", "ddd": 0, "assets": [], "layers": [] }' > public/lottie/luxeevents.json

echo "✅ Composant et animation Lottie réinstallés. Relance le build."
