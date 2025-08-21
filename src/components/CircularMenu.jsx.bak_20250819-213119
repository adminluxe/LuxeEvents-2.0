import React from 'react';
import { Link } from 'react-router-dom';

export default function CircularMenu(){
  const [open,setOpen]=React.useState(false);
  const itemCls = "w-12 h-12 rounded-full flex items-center justify-center shadow bg-white/80 dark:bg-black/60 backdrop-blur";
  return (
    <div className="fixed bottom-5 right-5 z-40">
      <div className={`relative transition-all ${open?'scale-100':'scale-95'}`}>
        {open && (
          <div className="absolute -top-2 -left-2 -right-2 -bottom-2">
            <div className="grid grid-cols-2 gap-3 p-3">
              <Link to="/" className={itemCls} title="Home">🏠</Link>
              <Link to="/services" className={itemCls} title="Services">💼</Link>
              <Link to="/devis" className={itemCls} title="Devis">📝</Link>
              <Link to="/mentions-legales" className={itemCls} title="Mentions">⚖️</Link>
            </div>
          </div>
        )}
        <button onClick={()=>setOpen(!open)} className="w-14 h-14 rounded-full bg-gradient-to-br from-yellow-300 to-yellow-500 text-black font-bold shadow-xl">
          {open?'×':'◎'}
        </button>
      </div>
    </div>
  );
}
