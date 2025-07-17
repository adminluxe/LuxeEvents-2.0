import { useEffect, useState } from "react";

export default function ParallaxWrapper({ children }) {
  const [offsetY, setOffsetY] = useState(0);

  useEffect(() => {
    const handleScroll = () => setOffsetY(window.scrollY);
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <div
      className="fixed top-0 left-0 w-full h-full -z-10 bg-cover bg-center transition-transform duration-300 ease-out"
      style={{
        backgroundImage: "url('/images/hero.jpg')",
        transform: `translateY(${offsetY * 0.3}px)`,
        backgroundAttachment: "scroll",
      }}
    />
  );
}
