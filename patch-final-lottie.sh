#!/bin/bash

echo "📦 Installation du lecteur Lottie..."
pnpm add @lottiefiles/react-lottie-player

echo "🧠 Correction du composant IntroAnimationLottie..."
cat << 'EOL' > src/components/IntroAnimationLottie.jsx
import React, { useEffect } from 'react'
import { Player } from '@lottiefiles/react-lottie-player'
import animationData from '../assets/luxeevents-intro.json'

const IntroAnimationLottie = ({ onFinish = () => {} }) => {
  useEffect(() => {
    const timeout = setTimeout(() => {
      onFinish()
    }, 6000)
    return () => clearTimeout(timeout)
  }, [onFinish])

  return (
    <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
      <Player
        autoplay
        keepLastFrame
        src={animationData}
        style={{ height: '300px', width: '300px' }}
      />
    </div>
  )
}

export default IntroAnimationLottie
EOL

echo "✅ Patch final appliqué avec succès."
