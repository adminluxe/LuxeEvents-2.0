import React, { useState, useEffect } from 'react';
export default function Teaser() {
  const [count, setCount] = useState('');
  useEffect(() => {
    const target = new Date(Date.now() + 7*24*60*60*1000);
    const tick = () => {
      const now = new Date();
      const diff = target - now;
      if (diff <= 0) return setCount('00:00:00');
      const h = String(Math.floor(diff/3600000)).padStart(2,'0');
      const m = String(Math.floor((diff%3600000)/60000)).padStart(2,'0');
      const s = String(Math.floor((diff%60000)/1000)).padStart(2,'0');
      setCount(\`\${h}:\${m}:\${s}\`);
    };
    tick(); const iv = setInterval(tick,1000);
    return ()=>clearInterval(iv);
  }, []);
  return (
    <main className="teaser">
      <h1>Coming Soon</h1>
      <p>🚀 Lancement dans {count}</p>
      <form onSubmit={e=>{e.preventDefault(); /* POST vers Strapi */}}>
        <input type="email" name="email" placeholder="Ton email" required/>
        <button>Préviens-moi</button>
      </form>
    </main>
  );
}
