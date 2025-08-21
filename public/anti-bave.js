(function(){
  try{
    const root = document.getElementById('root') || document.getElementById('app');
    if(!root) return;
    const isText = n => n && n.nodeType === Node.TEXT_NODE;
    const strip = s => (s||'').replace(/\s+/g,' ').trim();

    const kill = [];
    for (const n of Array.from(document.body.childNodes)) {
      if (n === root) break;                 // on ne touche pas au rendu React
      if (isText(n)) {
        const t = strip(n.textContent);
        if (/^rassurants\./i.test(t) || /rassurants\.\s*["»>]?\s*rassurants\./i.test(t)) kill.push(n);
      } else if (n.nodeType === 1 && !n.contains(root)) {
        const t = strip(n.textContent);
        if (/rassurants\.\s*["»>]?\s*rassurants\./i.test(t)) kill.push(n);
      }
    }
    kill.forEach(n => n.remove());
  }catch(e){}
})();
