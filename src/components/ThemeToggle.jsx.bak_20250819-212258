import React from "react";
import { ThemeContext } from "../theme/ThemeProvider";
export default function ThemeToggle() {
  const { theme, setTheme } = React.useContext(ThemeContext);
  const next = theme==="dark" ? "light" : "dark";
  return (
    <button
      aria-label="Toggle theme"
      className="px-3 py-2 rounded-lg ring-1 ring-white/20 bg-white/10 text-white text-sm"
      onClick={() => setTheme(next)}
    >
      {theme==="dark" ? "☀️" : "🌙"}
    </button>
  );
}
