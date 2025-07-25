import React from 'react';

export default function SoundController() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: SoundController.jsx</div>
    <div className="absolute top-4 right-4 z-50 flex items-center space-x-2 bg-black bg-opacity-50 backdrop-blur px-3 py-2 rounded-full shadow">
      <button onClick={() => setMuted((m) => !m)} className="text-white">
        {muted ? <VolumeX size={20} /> : <Volume2 size={20} />}
      </button>
      <input
        type="range"
        min={0}
        max={1}
        step={0.01}
        value={volume}
        onChange={(e) => setVolume(parseFloat(e.target.value))}
        className="w-20 accent-yellow-400"
      />
    </div>
    </>
  );
}
