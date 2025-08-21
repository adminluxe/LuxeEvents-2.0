import React from "react";
export const ThemeContext = React.createContext({theme:"dark", setTheme:()=>{}});
export default function ThemeProvider({children}) {
  const [theme, setTheme] = React.useState(
    document.documentElement.classList.contains("dark") ? "dark" : "light"
  );
  React.useEffect(()=>{
    document.documentElement.classList.toggle("dark", theme==="dark");
    localStorage.setItem("theme", theme);
  },[theme]);
  return <ThemeContext.Provider value={{theme, setTheme}}>{children}</ThemeContext.Provider>;
}
