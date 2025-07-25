import React from 'react';

export default function ThemeToggle() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: ThemeToggle.jsx</div>
    <button
      onClick={toggle}
      className="fixed bottom-6 right-6 z-50 bg-gradient-to-tr from-yellow-500 via-white to-yellow-500 dark:from-black dark:to-yellow-800 dark:text-yellow-300 text-yellow-600 backdrop-blur-md p-3 rounded-full transition-transform hover:rotate-180 duration-700"
      title="Changer de thème"
    >
      {dark ? <Sun size={20} /> : <Moon size={20} />}
    </button>
  );
}
    </>
  );
}
