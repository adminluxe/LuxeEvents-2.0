(function(){
  try {
    const s = localStorage.getItem("theme");
    const m = window.matchMedia("(prefers-color-scheme: dark)").matches;
    const dark = s ? (s === "dark") : m;
    document.documentElement.classList.toggle("dark", !!dark);
  } catch(e){}
})();
