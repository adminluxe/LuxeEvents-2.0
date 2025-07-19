#!/bin/bash

echo "🎨 Injection de l'interface immersive LuxeEvents..."

mkdir -p src/components src/styles src/app

cp -R ./src/components/* src/components/
cp -R ./src/styles/* src/styles/
cp -R ./src/app/page.tsx src/app/

echo "✅ Composants Hero, Audio, FadeUp, Scroll CSS injectés."
echo "Redémarre ton dev server pour voir le résultat ➜ http://localhost:5173"
