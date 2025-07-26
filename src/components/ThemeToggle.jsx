import React, { useEffect, useState } from 'react';

export default function ThemeToggle() {
  const [dark, setDark] = useState(false);

  useEffect(() => {
    document.documentElement.classList.toggle('dark', dark);
  }, [dark]);

  return (
    <div className="fixed bottom-4 right-4 z-50">
      <button
        className="p-2 border rounded-full shadow-md"
        onClick={() => setDark(!dark)}
      >
        {dark ? '☀️' : '🌙'}
      </button>
    </div>
  );
}
