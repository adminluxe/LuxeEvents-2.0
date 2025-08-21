"use client";

import { Facebook, Instagram, Mail, MapPin } from "lucide-react";
import { motion } from "framer-motion";
import { Link } from "react-router-dom";

export default function FooterLuxe() {
  return (
    <footer className="bg-black text-white py-12 mt-20 border-t border-gold">
      <div className="container mx-auto px-4 grid grid-cols-1 md:grid-cols-3 gap-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
        >
          <h3 className="text-2xl font-bold text-gold mb-4">LuxeEvents</h3>
          <p className="text-sm text-white/70 leading-relaxed">
            Événements haut de gamme, le luxe à la portée de tous.<br />
            <span className="italic">Excellence. Élégance. Expérience.</span>
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <h4 className="text-lg font-semibold mb-4 text-gold">Navigation</h4>
          <ul className="space-y-2 text-sm">
            <li><Link to="/" className="hover:text-gold transition text-white">Accueil</Link></li>
            <li><Link to="/" className="hover:text-gold transition text-white">Notre Histoire</Link></li>
            <li><Link to="/" className="hover:text-gold transition text-white">Services</Link></li>
            <li><Link to="/devis" className="hover:text-gold transition text-white">Demande de devis</Link></li>
          </ul>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <h4 className="text-lg font-semibold mb-4 text-gold">Contact</h4>
          <ul className="space-y-3 text-sm">
            <li className="flex items-center gap-2 text-white/80"><MapPin size={18} /> Paris, France</li>
            <li className="flex items-center gap-2 text-white/80"><Mail size={18} /> contact@luxeevents.me</li>
            <li className="flex gap-4 mt-4 text-white">
              <a href="#" className="hover:text-gold transition"><Facebook size={20} /></a>
              <a href="#" className="hover:text-gold transition"><Instagram size={20} /></a>
            </li>
          </ul>
        </motion.div>
      </div>
      <div className="text-center text-white/40 text-sm mt-12">
        &copy; {new Date().getFullYear()} LuxeEvents – Tous droits réservés.
      </div>
    </footer>
  );
}
