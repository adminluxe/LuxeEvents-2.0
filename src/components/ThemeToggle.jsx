import React, {useEffect, useState} from "react";
export default function ThemeToggle(){
  const [theme, setTheme] = useState("light");
  useEffect(()=>{
    const saved = localStorage.getItem("theme") || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark":"light");
    setTheme(saved);
    document.documentElement.setAttribute("data-theme", saved);
  },[]);
  const toggle = ()=>{
    const next = theme === "dark" ? "light" : "dark";
    setTheme(next);
    localStorage.setItem("theme", next);
    document.documentElement.setAttribute("data-theme", next);
  };
  return <button className="lx-btn" onClick={toggle} aria-label="Toggle theme">{theme === "dark" ? "☀️" : "🌙"} Theme</button>;
}
