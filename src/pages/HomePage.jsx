import ThemeToggle from "@/components/ThemeToggle";
import React from 'react';
import CircularMenu from "@/components/CircularMenu";
import useIntroSound from "@/hooks/useIntroSound";import MuteToggle from "@/components/MuteToggle";
import HeroSection from "@/components/HeroSection";
import NextSection from "@/components/NextSection";
import SwiperStory from "@/components/SwiperStory";
import TimelineSection from "@/components/TimelineSection";
import RevealSection from "@/components/RevealSection";
import IntroAnimation from '../components/IntroAnimation';

export default function HomePage() {
  return (
    <div className="min-h-screen scroll-snap-y overflow-y-scroll h-screen">
      <section id="hero"><HeroSection /></section>
      <NextSection />
      <SwiperStory />
      <TimelineSection />
      <RevealSection />
        {/* Menu circulaire */}\n        <CircularMenu />
    </div>
  );
}
