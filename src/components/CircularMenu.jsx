import React from 'react';

export default function CircularMenu() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: CircularMenu.jsx</div>
    <div className="flex flex-col items-center gap-4">
      <Link to="/" className="text-white hover:text-gold transition">🏠 Accueil</Link>
      <Link to="/devis" className="text-white hover:text-gold transition">📩 Devis</Link>
      <button onClick={toggleLanguage} className="text-white hover:text-gold transition">🌐 Langue</button>

      <motion.button whileTap={{ scale: 0.8 }}>
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
    </>
  );
}
