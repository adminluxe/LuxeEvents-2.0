#!/bin/bash

echo "💠 Injection automatique : Intro Lottie + Fond de page LuxeEvents"

# 📌 1. Injection du nouvel import
sed -i "s|import IntroAnimation from './components/IntroAnimation';|import IntroAnimationLottie from './components/IntroAnimationLottie';|" src/App.jsx

# 📌 2. Remplacement de l’appel <IntroAnimation /> par <IntroAnimationLottie />
sed -i '/<IntroAnimation/,/setIntroDone(true);/{s/IntroAnimation/IntroAnimationLottie/g}' src/App.jsx

# 📌 3. Ajout d’un background visuel via <div class="..."> dans App.jsx
# On ajoute juste avant <main>
sed -i '/return (/,/<main /s|<main|<div className="fixed inset-0 -z-10 bg-no-repeat bg-cover bg-center opacity-20 dark:opacity-10" style={{ backgroundImage: "url('/media/background.png')" }}></div>\n\n  <main|' src/App.jsx

echo "✅ Lottie + fond visuel intégrés avec élégance."
