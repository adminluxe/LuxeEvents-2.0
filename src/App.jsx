import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Hero from './components/Hero';
import ServicesGrid from './components/ServicesGrid';
import Events from './pages/Events';
import Contact from './pages/Contact';
export default function App() {
  return (
    <Router>
      <nav className="p-6 flex space-x-4">
        <Link to="/" className="font-bold">Home</Link>
        <Link to="/events">Événements</Link>
        <Link to="/contact">Contact</Link>
      </nav>
      <main className="px-6">
        <Routes>
          <Route path="/" element={<><Hero /><ServicesGrid /></>} />
          <Route path="/events" element={<Events />} />
          <Route path="/contact" element={<Contact />} />
        </Routes>
      </main>
    </Router>
  );
}
