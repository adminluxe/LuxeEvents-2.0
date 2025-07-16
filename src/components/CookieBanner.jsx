import React, { useState, useEffect } from 'react';

export default function CookieBanner() {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const accepted = localStorage.getItem('cookiesAccepted');
    if (!accepted) setVisible(true);
  }, []);

  const acceptCookies = () => {
    localStorage.setItem('cookiesAccepted', 'true');
    setVisible(false);
  };

  if (!visible) return null;

  return (
    <div className="fixed bottom-0 inset-x-0 bg-white border-t border-gray-200 p-4 z-50 shadow-md">
      <div className="max-w-7xl mx-auto flex flex-col sm:flex-row justify-between items-center gap-4">
        <p className="text-sm text-gray-700 text-center sm:text-center">
          Nous utilisons des cookies pour améliorer votre expérience sur LuxeEvents.
        </p>
        <button
          onClick={acceptCookies}
          className="bg-yellow-500 hover:bg-yellow-600 text-white text-sm font-semibold px-4 py-2 rounded"
        >
          J'accepte
        </button>
      </div>
    </div>
  );
}
