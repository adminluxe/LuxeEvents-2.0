import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Gallery from './pages/Gallery.jsx';  // <- extension ajoutée
import './App.css';

function Home() {
  return (
    <div style={{ marginTop: '2rem' }}>
      <p>Bienvenue sur la plateforme d’événements les plus chics et audacieux.</p>
    </div>
  );
}

function App() {
  return (
    <Router>
      <div className="App">
        <h1>LuxeEvents.me</h1>
        <p>Le luxe, à la portée de tous.</p>

        <nav style={{ marginTop: '1rem' }}>
          <Link to="/" style={{ marginRight: '1rem' }}>Accueil</Link>
          <Link to="/gallery">Galerie</Link>
        </nav>

        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/gallery" element={<Gallery />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
