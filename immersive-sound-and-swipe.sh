#!/bin/bash
echo "🎶 Ajout des sons immersifs personnalisés + activation swipe/storytelling..."

# 1. Copier les fichiers audio dans public/sounds
mkdir -p public/sounds
cp ~/Téléchargements/about.mp3 public/sounds/about.mp3
cp ~/Téléchargements/events.mp3 public/sounds/events.mp3
cp ~/Téléchargements/contact.mp3 public/sounds/contact.mp3

# 2. Ajout swiper horizontal immersif (si pas encore là)
mkdir -p src/components

cat > src/components/SwipeStory.jsx << 'EOF'
import { Swiper, SwiperSlide } from "swiper/react";
import { EffectCoverflow } from "swiper/modules";
import "swiper/css";
import "swiper/css/effect-coverflow";

const slides = [
  { title: "L'Idée", text: "Rendre le luxe événementiel universel." },
  { title: "La Vision", text: "Fusionner élégance, tech et émotion." },
  { title: "La Réalité", text: "LuxeEvents, l’expérience réinventée." }
];

export default function SwipeStory() {
  return (
    <section className="bg-white dark:bg-zinc-900 py-20 px-4 scroll-snap-start">
      <div className="max-w-5xl mx-auto text-center">
        <Swiper
          effect={"coverflow"}
          grabCursor={true}
          centeredSlides={true}
          slidesPerView={"auto"}
          coverflowEffect={{
            rotate: 50,
            stretch: 0,
            depth: 100,
            modifier: 1,
            slideShadows: true,
          }}
          modules={[EffectCoverflow]}
          className="mySwiper"
        >
          {slides.map((s, i) => (
            <SwiperSlide key={i} className="w-64 bg-yellow-100 dark:bg-zinc-700 p-6 rounded-xl shadow-lg">
              <h3 className="text-xl font-semibold mb-2 text-zinc-800 dark:text-yellow-50">{s.title}</h3>
              <p className="text-zinc-600 dark:text-zinc-200">{s.text}</p>
            </SwiperSlide>
          ))}
        </Swiper>
      </div>
    </section>
  );
}
EOF

# 3. Intégration dans HomePage.jsx si pas encore présent
grep -q SwipeStory src/pages/HomePage.jsx || sed -i '/<\/StoryTimeline>/a       <SwipeStory />' src/pages/HomePage.jsx

grep -q SwipeStory src/pages/HomePage.jsx || sed -i '/StoryTimeline/a import SwipeStory from "@/components/SwipeStory";' src/pages/HomePage.jsx

# 4. Commit
git add public/sounds/*.mp3 src/components/SwipeStory.jsx src/pages/HomePage.jsx
git commit -m "🔊 Sons immersifs About/Events/Contact + swiper narratif coverflow"

echo "✅ Sons & swiper immersif ajoutés. L’expérience se magnifie..."
