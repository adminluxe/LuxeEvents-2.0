import React from 'react';

export default function CookieBanner() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: CookieBanner.jsx</div>
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



    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: CookieBanner.jsx</div>
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
    </>
  );
}
