import { Link } from 'react-router-dom'
export default function Navbar() {
  return (
    <nav className="fixed top-0 w-full bg-black/50 backdrop-blur-md z-50">
      <div className="max-w-7xl mx-auto flex justify-between items-center p-4">
        <Link to="/" className="text-luxeGold text-2xl font-serif">LuxeEvents</Link>
        <div className="space-x-6 text-luxeWhite">
          <Link to="/reserver"     className="hover:text-gold">Réserver</Link>
          <Link to="/moments"      className="hover:text-gold">Moments</Link>
          <Link to="/temoignages"  className="hover:text-gold">Témoignages</Link>
          <Link to="/contact"      className="hover:text-gold">Contact</Link>
        </div>
      </div>
    </nav>
  )
}
