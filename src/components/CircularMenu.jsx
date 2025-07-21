import { Link } from "react-router-dom";
import { useState } from "react";
  import { useTranslation } from "react-i18next";
  import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";
import { Menu, X } from "lucide-react";

const items = [
  { label: "Accueil", anchor: "#hero" },
  { label: "Story", anchor: "#story" },
  { label: "Services", anchor: "#services" },
  { label: "Devis", anchor: "#quote" },
  { label: "Contact", anchor: "#footer" },
];

export default function CircularMenu() {
  const [open, setOpen] = useState(false);
  const { i18n } = useTranslation();
  const toggleLanguage = () => i18n.changeLanguage(i18n.language === "fr" ? "en" : "fr");
  import { useTranslation } from "react-i18next";
  const { i18n } = useTranslation();
  const toggleLanguage = () => i18n.changeLanguage(i18n.language === "fr" ? "en" : "fr");
  import { useTranslation } from "react-i18next";

  return (<><>
      <div className="flex flex-col items-center gap-4">

        <Link to="/" className="text-white hover:text-gold transition">🏠 Accueil</Link>

        <Link to="/devis" className="text-white hover:text-gold transition">📩 Devis</Link>

        <button onClick={toggleLanguage} className="text-white hover:text-gold transition">🌐 Langue</button>

      </div>
    <div className="fixed top-4 right-4 z-[1000]">
      <motion.button
        whileTap={{ scale: 0.8 }}
        onClick={() => setOpen(!open)}
        className="p-3 rounded-full bg-gold text-black shadow-xl transition-all hover:scale-110"
      >
        {open ? <X /> : <Menu />}
      </motion.button>

      {open && (
        <motion.ul
          initial={{ opacity: 0, scale: 0 }}
          animate={{ opacity: 1, scale: 1 }}
          className="absolute top-full mt-4 right-0 flex flex-col gap-2 bg-white/90 rounded-xl p-4 backdrop-blur shadow-lg"
        >
          {items.map(({ label, anchor }, i) => (
            <motion.li
              key={i}
              initial={{ x: 20, opacity: 0 }}
              animate={{ x: 0, opacity: 1 }}
              transition={{ delay: i * 0.05 }}
            >
              <a
                href={anchor}
                className="block text-black hover:text-gold transition font-medium"
                onClick={() => setOpen(false)}
              >
                {label}
              </a>
            </motion.li>
          ))}
        </motion.ul>
      )}
    </div>
  );
}
