#!/bin/bash

### FINAL V1 RESTORATION SCRIPT – LUXEEVENTS 🌟
# Ce script restaure tous les composants clés et active les fonctionnalités immersives validées pour la V1 officielle.

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOGFILE="logs/build-final-V1-$DATE.log"
mkdir -p logs

# 1. 🔁 Restore HeroSection (animation diamant + intro + bg + bouton mute)
cat << 'EOF' > src/components/HeroSection.jsx
import React, { useState } from 'react';
import './HeroSection.css';

export default function HeroSection() {
  const [muted, setMuted] = useState(true);

  return (
    <section className="min-h-screen flex flex-col justify-center items-center text-center px-4 bg-[url('/bg-luxeevents.png')] bg-cover bg-center">
      <div className="diamond-animation mb-4"></div>
      <h1 className="text-3xl md:text-5xl font-bold text-gold mb-4 animate-fadeInUp">
        Sublimez votre événement
      </h1>
      <p className="text-black/80 dark:text-white/80 mb-6">
        Le luxe à la portée de tous – Pour une expérience inoubliable.
      </p>
      <button
        className="bg-white dark:bg-black border border-gold text-gold px-4 py-2 rounded hover:bg-gold hover:text-white transition"
        onClick={() => setMuted(!muted)}
      >
        {muted ? 'Activer le son' : 'Désactiver le son'}
      </button>
      <audio
        src="/audio/ambiance-luxe.mp3"
        autoPlay
        loop
        muted={muted}
        className="hidden"
      />
    </section>
  );
}
EOF

# 2. 🎠 Restore SwipeStory (swiper immersif + swipe détecté)
cat << 'EOF' > src/components/SwipeStory.jsx
import React from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import { EffectFade, Pagination } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/effect-fade';

export default function SwipeStory() {
  return (
    <section className="w-full h-[80vh] px-4">
      <Swiper
        modules={[EffectFade, Pagination]}
        effect="fade"
        pagination={{ clickable: true }}
        className="h-full"
      >
        <SwiperSlide><div className="h-full bg-black text-white flex items-center justify-center">Story 1</div></SwiperSlide>
        <SwiperSlide><div className="h-full bg-gold text-black flex items-center justify-center">Story 2</div></SwiperSlide>
        <SwiperSlide><div className="h-full bg-white text-black flex items-center justify-center">Story 3</div></SwiperSlide>
      </Swiper>
    </section>
  );
}
EOF

# 3. 💬 Restore TestimonialsSection.jsx (style immersif)
cat << 'EOF' > src/components/TestimonialsSection.jsx
import React from 'react';

export default function TestimonialsSection() {
  return (
    <section className="py-16 px-4 text-center bg-black text-white">
      <h2 className="text-2xl md:text-4xl font-bold mb-8">Ils nous ont fait confiance</h2>
      <div className="grid md:grid-cols-3 gap-6">
        <div className="bg-white/10 p-6 rounded-xl backdrop-blur">Un service incroyable, tout était parfait! ⭐⭐⭐⭐⭐</div>
        <div className="bg-white/10 p-6 rounded-xl backdrop-blur">Une organisation digne des plus grands. Merci! 🙏</div>
        <div className="bg-white/10 p-6 rounded-xl backdrop-blur">Une soirée magique, on recommande à 200%! ✨</div>
      </div>
    </section>
  );
}
EOF

# 4. 🌐 Restore LanguageSwitcher.jsx (FR/EN)
cat << 'EOF' > src/components/LanguageSwitcher.jsx
import React from 'react';

export default function LanguageSwitcher() {
  return (
    <div className="fixed top-4 right-4 z-50">
      <button className="px-2 py-1 mx-1 border rounded text-sm">FR</button>
      <button className="px-2 py-1 mx-1 border rounded text-sm">EN</button>
    </div>
  );
}
EOF

# 5. 🌗 Restore ThemeToggle.jsx (dark/light)
cat << 'EOF' > src/components/ThemeToggle.jsx
import React, { useEffect, useState } from 'react';

export default function ThemeToggle() {
  const [dark, setDark] = useState(false);

  useEffect(() => {
    document.documentElement.classList.toggle('dark', dark);
  }, [dark]);

  return (
    <div className="fixed bottom-4 right-4 z-50">
      <button
        className="p-2 border rounded-full shadow-md"
        onClick={() => setDark(!dark)}
      >
        {dark ? '☀️' : '🌙'}
      </button>
    </div>
  );
}
EOF

# 6. 📤 Restore /api/contact.js (pour formulaire de devis)
cat << 'EOF' > api/contact.js
export default async function handler(req, res) {
  if (req.method === 'POST') {
    const { name, email, message } = req.body;

    if (!name || !email || !message) {
      return res.status(400).json({ success: false, error: 'Champs manquants' });
    }

    // À compléter avec Postfix/Mailgun
    console.log('📧 Nouveau message:', { name, email, message });

    return res.status(200).json({ success: true });
  }

  return res.status(405).json({ success: false, error: 'Méthode non autorisée' });
}
EOF

# 7. 🌀 Lancer rebuild propre + push final
npm run build | tee "$LOGFILE"
vercel --prod --force --yes

echo "✅ Final V1 restaurée avec succès. 🎉"
