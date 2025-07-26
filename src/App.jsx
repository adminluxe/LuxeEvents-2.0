import React from 'react';
import HeroSection from './components/HeroSection';
import ServicesSection from './components/ServicesSection';
import QuoteForm from './components/QuoteForm';
import TimelineSection from './components/TimelineSection';
import SwipeStory from './components/SwipeStory';
import DarkModeToggle from "./components/DarkModeToggle";
import Footer from './components/Footer';

function App() {
  <DarkModeToggle />
  return (
    <>
      <HeroSection />
      <ServicesSection />
      <QuoteForm />
      <TimelineSection />
      <SwipeStory />
      <Footer />
    </>
  );
}

export default App;
