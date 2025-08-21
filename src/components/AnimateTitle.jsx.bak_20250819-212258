import React, { useEffect, useRef } from "react";
export default function AnimateTitle({ text, as:Comp="h1", className="" }) {
  const ref = useRef(null);
  useEffect(() => {
    const el = ref.current; if (!el) return;
    const words = Array.from(el.querySelectorAll(".word"));
    words.forEach((w, i) => setTimeout(() => w.classList.add("in"), 45 * i));
  }, []);
  return (
    <Comp className={className}>
      {text.split(" ").map((w,i) => (
        <span key={i} className="word">{w}{i<text.split(" ").length-1 ? " " : ""}</span>
      ))}
    </Comp>
  );
}
