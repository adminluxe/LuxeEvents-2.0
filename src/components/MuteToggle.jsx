import { Volume2, VolumeX } from "lucide-react";

export default function MuteToggle({ muted, toggle }) {
  return (
    <button
      onClick={toggle}
      className="fixed top-4 right-4 z-50 p-2 bg-white/80 dark:bg-zinc-800/80 backdrop-blur rounded-full shadow-md"
    >
      {muted ? <VolumeX size={20} /> : <Volume2 size={20} />}
    </button>
  );
}
