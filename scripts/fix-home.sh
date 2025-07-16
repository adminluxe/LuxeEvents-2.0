#!/bin/bash

HOMEPAGE="src/pages/HomePage.jsx"

# Sécurise un backup
cp "$HOMEPAGE" "${HOMEPAGE}.bak"

# Nettoie les anciens imports doublons et réinsère au propre
sed -i '/HeroSection/d;/NextSection/d;/SwiperStory/d;/TimelineSection/d;/RevealSection/d' "$HOMEPAGE"
sed -i '/^import/a\
import HeroSection from "@/components/HeroSection";\
import NextSection from "@/components/NextSection";\
import SwiperStory from "@/components/SwiperStory";\
import TimelineSection from "@/components/TimelineSection";\
import RevealSection from "@/components/RevealSection";' "$HOMEPAGE"

# Corrige le contenu de la fonction HomePage (partie JSX)
sed -i '/return (/,+10c\
  return (\
    <div className="min-h-screen scroll-snap-y overflow-y-scroll h-screen">\
      <HeroSection />\
      <NextSection />\
      <SwiperStory />\
      <TimelineSection />\
      <RevealSection />\
    </div>\
  );' "$HOMEPAGE"
