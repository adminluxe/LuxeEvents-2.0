import React from 'react';

export default function MuteToggle() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: MuteToggle.jsx</div>
    <button
      onClick={toggle}
      className="fixed top-4 right-4 z-50 p-2 bg-white/80 dark:bg-zinc-800/80 backdrop-blur rounded-full shadow-md"
    >
      {muted ? <VolumeX size={20} /> : <Volume2 size={20} />}
    </button>
  );
}
    </>
  );
}
