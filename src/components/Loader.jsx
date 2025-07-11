import React, { useEffect, useState } from 'react';
export default function Loader({ children }) {
  const [ready, setReady] = useState(false);
  useEffect(() => {
    const t = setTimeout(() => setReady(true), 1200);
    return () => clearTimeout(t);
  }, []);
  if (!ready) {
    return (
      <div style={{
        position:'fixed',top:0,left:0,right:0,bottom:0,
        background:'#000',display:'flex',
        alignItems:'center',justifyContent:'center',
        color:'#fff',fontSize:'2rem',zIndex:9999
      }}>✨ LuxeEvents ✨</div>
    );
  }
  return children;
}
