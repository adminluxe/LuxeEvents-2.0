#!/bin/bash
HOMEPAGE="src/pages/HomePage.jsx"
cp "$HOMEPAGE" "${HOMEPAGE}.bak"

# Supprime les imports en double
sed -i '/HeroSection/d;/NextSection/d;/SwiperStory/d;/TimelineSection/d;/RevealSection/d' "$HOMEPAGE"

# Supprime aussi les lignes vides en double éventuelles
sed -i '/^$/N;/^\n$/D' "$HOMEPAGE"

# Réinjecte proprement
sed -i '/^import/a\
import HeroSection from "@/components/HeroSection";\
import NextSection from "@/components/NextSection";\
import SwiperStory from "@/components/SwiperStory";\
import TimelineSection from "@/components/TimelineSection";\
import RevealSection from "@/components/RevealSection";' "$HOMEPAGE"
