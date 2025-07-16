import React from 'react';
import HeroSection from "@/components/HeroSection";
import NextSection from "@/components/NextSection";
import SwiperStory from "@/components/SwiperStory";
import TimelineSection from "@/components/TimelineSection";
import RevealSection from "@/components/RevealSection";

export default function HomePage() {
  return (
    <div className="min-h-screen scroll-snap-y overflow-y-scroll h-screen">
      <HeroSection />
      <NextSection />
      <SwiperStory />
      <TimelineSection />
      <RevealSection />
    </div>
  );
}
