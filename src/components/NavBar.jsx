import { NavLink } from 'react-router-dom'

export default function NavBar({ children }) {
  return (
    <nav className="flex items-center justify-between px-8 py-4 bg-black text-white">
      <div className="space-x-6">
        <NavLink to="/" className="hover:underline">Accueil</NavLink>
        <NavLink to="/about" className="hover:underline">À Propos</NavLink>
        <NavLink to="/quote" className="hover:underline">Devis</NavLink>
        <NavLink to="/gallery" className="hover:underline">Galerie</NavLink>
      </div>
      <div className="flex items-center space-x-4">
        {children}
      </div>
    </nav>
  )
}
