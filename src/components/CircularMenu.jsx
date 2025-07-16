import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { useNavigate } from "react-router-dom";
import { Menu, X, Sparkles, FileText, Image, Layers3 } from "lucide-react";

const links = [
  { path: "/media", label: "Médias", icon: Image },
  { path: "/services", label: "Services", icon: Layers3 },
  { path: "/demande-de-devis", label: "Devis", icon: FileText },
];

export default function CircularMenu() {
  const [open, setOpen] = useState(false);
  const [visible, setVisible] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 200) setVisible(true);
      else setVisible(false);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <AnimatePresence>
      {visible && (
        <motion.div
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: 50 }}
          transition={{ duration: 0.4 }}
          className="fixed top-6 right-6 z-50"
        >
          <button
            onClick={() => setOpen(!open)}
            className="bg-black/50 dark:bg-yellow-100 dark:text-yellow-800 text-yellow-400 p-6 rounded-full backdrop-blur hover:rotate-180 transition-transform duration-500"
            title={open ? "Fermer le menu" : "Ouvrir le menu"}
          >
            {open ? <X size={24} /> : <Menu size={24} />}
          </button>

          <AnimatePresence>
            {open && (
              <motion.ul
                initial={{ opacity: 0, scale: 0.5 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.5 }}
                transition={{ type: "spring", stiffness: 260, damping: 20 }}
                className="absolute bottom-20 right-0 space-y-4 flex flex-col items-end"
              >
                {links.map(({ path, label, icon: Icon }) => (
                  <li key={path}>
                    <button
                      onClick={() => navigate(path)}
                      className="flex items-center space-x-2 px-4 py-2 rounded-xl bg-yellow-400 dark:bg-yellow-200 text-white dark:text-black hover:bg-yellow-300 shadow-xl backdrop-blur-md"
                      title={label}
                    >
                      <Icon size={18} />
                      <span className="text-sm font-semibold">{label}</span>
                    </button>
                  </li>
                ))}
              </motion.ul>
            )}
          </AnimatePresence>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
