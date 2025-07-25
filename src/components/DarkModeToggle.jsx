import React from 'react';

export default function DarkModeToggle() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: DarkModeToggle.jsx</div>
    <button
      onClick={toggleDarkMode}
      aria-label="Toggle Dark Mode"
      className="fixed top-5 right-5 p-2 rounded-full bg-white dark:bg-black shadow-lg z-50"
    >
      {dark ? (
        <Sun className="w-6 h-6 text-yellow-300" />
      ) : (
        <Moon className="w-6 h-6 text-gray-900" />
      )}
    </button>
  );
}
    </>
  );
}
