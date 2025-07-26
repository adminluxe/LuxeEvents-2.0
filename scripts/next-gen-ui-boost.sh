#!/bin/bash

echo "🌠 LUXEEVENTS – NEXT GEN UI BOOST ACTIVATION"
echo "📱 Responsive + 🌒 DarkMode + 📦 PWA – let's go!"

# 1. Injecte toggle DarkMode visible dans HeroSection
echo "🌓 Injection toggle dark mode..."
cat << 'EOC' > src/components/DarkModeToggle.jsx
import { useEffect, useState } from 'react';

export default function DarkModeToggle() {
  const [isDark, setIsDark] = useState(false);

  useEffect(() => {
    const saved = localStorage.getItem('theme');
    if (saved === 'dark' || (!saved && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      document.documentElement.classList.add('dark');
      setIsDark(true);
    }
  }, []);

  const toggleTheme = () => {
    const html = document.documentElement;
    if (html.classList.contains('dark')) {
      html.classList.remove('dark');
      localStorage.setItem('theme', 'light');
      setIsDark(false);
    } else {
      html.classList.add('dark');
      localStorage.setItem('theme', 'dark');
      setIsDark(true);
    }
  };

  return (
    <button
      onClick={toggleTheme}
      className="fixed top-4 right-4 z-50 bg-gold text-white dark:bg-black dark:text-gold px-3 py-1 rounded shadow"
    >
      {isDark ? '☀️' : '🌙'}
    </button>
  );
}
EOC

# 2. Ajoute DarkModeToggle à App.jsx
sed -i '/import Footer/i import DarkModeToggle from "\.\/components\/DarkModeToggle";' src/App.jsx
sed -i 's/return (/<DarkModeToggle \/>\n  return (/g' src/App.jsx

# 3. Installe Vite PWA plugin
echo "🔌 Installation de vite-plugin-pwa..."
pnpm add -D vite-plugin-pwa

# 4. Configure vite.config.js pour PWA
echo "⚙️ Configuration Vite pour PWA..."
cat << 'EOV' >> vite.config.js

import { VitePWA } from 'vite-plugin-pwa'

export default {
  plugins: [
    VitePWA({
      registerType: 'autoUpdate',
      includeAssets: ['favicon.ico', 'logo192.png', 'logo512.png'],
      manifest: {
        name: 'LuxeEvents',
        short_name: 'LuxeEvents',
        description: 'Le luxe à la portée de tous!',
        theme_color: '#ffffff',
        background_color: '#000000',
        display: 'standalone',
        start_url: '/',
        icons: [
          {
            src: 'logo192.png',
            sizes: '192x192',
            type: 'image/png'
          },
          {
            src: 'logo512.png',
            sizes: '512x512',
            type: 'image/png'
          }
        ]
      }
    })
  ]
}
EOV

# 5. Active classes responsive
echo "📱 Patch classes Tailwind pour responsive mobile..."

grep -rl 'text-3xl' src/components | xargs sed -i 's/text-3xl/md:text-5xl text-3xl/g'
grep -rl 'text-xl' src/components | xargs sed -i 's/text-xl/md:text-2xl text-xl/g'
grep -rl 'px-4' src/components | xargs sed -i 's/px-4/md:px-8 px-4/g'
grep -rl 'py-2' src/components | xargs sed -i 's/py-2/md:py-4 py-2/g'

# 6. Rebuild et déploiement
echo "🔁 Rebuild + push final..."
npm run build && vercel --prod --force --yes

echo "✅ FINITO – LuxeEvents boosté mobile + dark + PWA offline-ready"
