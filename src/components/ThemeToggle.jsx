import { useEffect, useState } from "react";
export default function ThemeToggle(){
  const [dark,setDark]=useState(false);
  useEffect(()=>{const s=localStorage.getItem("theme");const d=s?s==="dark":true;setDark(d);document.documentElement.classList.toggle("dark",d);},[]);
  const toggle=()=>{const n=!dark;setDark(n);document.documentElement.classList.toggle("dark",n);try{localStorage.setItem("theme",n?"dark":"light");}catch{}};
  return <button aria-label="Toggle dark mode" className="px-3 py-1 rounded-full border border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-black transition" onClick={toggle}>{dark?"🌙":"☀️"}</button>;
}
