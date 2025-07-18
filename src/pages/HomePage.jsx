import Layout from "@/layouts/Layout";
import React from 'react';
import CircularMenu from "@/components/CircularMenu";
import HeroSection from "@/components/HeroSection";
import NextSection from "@/components/NextSection";
import SwiperStory from "@/components/SwiperStory";
import TimelineSection from "@/components/TimelineSection";
import RevealSection from "@/components/RevealSection";

export default function HomePage() {
  return (
    <Layout>
      <div className="min-h-screen scroll-snap-y overflow-y-scroll h-screen">
        <section id="hero"><HeroSection /></section>
        <NextSection />
        <SwiperStory />
        <TimelineSection />
        <RevealSection />
        {/* Menu circulaire */}
        <CircularMenu />
      </div>
    </Layout>
  );
}
