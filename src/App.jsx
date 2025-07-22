import React from 'react'
import IntroAnimationLottie from './components/IntroAnimationLottie'
import AudioAmbient from './components/AudioAmbient'
import HeroSection from './components/HeroSection'
import StorySwiper from './components/StorySwiper'
import TimelineMagique from './components/TimelineMagique'
import QuoteForm from './components/QuoteForm'
import FooterLuxe from './components/FooterLuxe'
import FadeUpWrapper from './components/FadeUpWrapper'

function App() {
  return (
    <>
      <AudioAmbient />
      <IntroAnimationLottie />
      <FadeUpWrapper>
        <HeroSection />
        <StorySwiper />
        <TimelineMagique />
        <QuoteForm />
        <FooterLuxe />
      </FadeUpWrapper>
    </>
  )
}

export default App
