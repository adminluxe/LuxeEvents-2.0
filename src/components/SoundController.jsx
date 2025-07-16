import { useState, useEffect } from "react";
import { Volume2, VolumeX } from "lucide-react";

export default function SoundController() {
  const [muted, setMuted] = useState(false);
  const [volume, setVolume] = useState(0.7);

  useEffect(() => {
    document.querySelectorAll("audio").forEach((audio) => {
      audio.volume = muted ? 0 : volume;
    });
  }, [muted, volume]);

  return (
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
  );
}
