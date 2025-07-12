import { useState, useEffect } from "react";
export default function DarkModeToggle() {
  const [mode, setMode] = useState("light");
  useEffect(() => {
    document.documentElement.classList.toggle("dark", mode==="dark");
  }, [mode]);
  return (
    <button onClick={() => setMode(m=>m==="light"?"dark":"light")}>
      {mode==="light"?"🌞":"🌙"}
    </button>
  );
}
