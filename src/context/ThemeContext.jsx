import { createContext, useContext, useEffect, useState } from "react";

const ThemeContext = createContext();

export const ThemeProvider = ({ children }) => {
  const [dark, setDark] = useState(false);

  useEffect(() => {
    const root = document.documentElement;
    root.classList.toggle("dark", dark);
    root.animate(
      [
        { opacity: 0.6, filter: dark ? "brightness(150%)" : "brightness(80%)" },
        { opacity: 1, filter: "brightness(100%)" }
      ],
      {
        duration: 700,
        easing: "ease-in-out",
      }
    );
  }, [dark]);

  return (
    <ThemeContext.Provider value={{ dark, toggle: () => setDark((d) => !d) }}>
      {children}
    </ThemeContext.Provider>
  );
};

export const useTheme = () => useContext(ThemeContext);
