import { useEffect, useState } from "react";
export default function ThemeToggle({ className="" }){
  const [dark, setDark] = useState(()=>document.documentElement.classList.contains("dark"));
  useEffect(()=>{ document.documentElement.classList.toggle("dark", dark); },[dark]);
  return (
    <button aria-label="Basculer le thème" className={`px-3 py-1 rounded-full border text-sm ${className}`}
      onClick={()=>setDark(d=>!d)}>{dark ? "🌙" : "☀️"}</button>
  );
}
