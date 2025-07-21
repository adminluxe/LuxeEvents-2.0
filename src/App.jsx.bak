import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import Footer from './components/Footer';
import CookieBanner from './components/CookieBanner';
import Home from './pages/Home';
import MediaPage from './pages/MediaPage';
import RequestQuotePage from './pages/RequestQuotePage';
import Services from './pages/Services';
import './i18n';

export default function App() {
  return (
    <>
      <Navbar />
      <main className="pt-16">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/media" element={<MediaPage />} />
          <Route path="/services" element={<Services />} />
          <Route path="/demande-de-devis" element={<RequestQuotePage />} />
        </Routes>
      </main>
      <Footer />
    <CookieBanner />
    </>
  );
}
