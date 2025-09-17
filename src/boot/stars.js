/**
 * LuxeEvents • Stars Canvas (safe HDPI)
 * - remplissage plein écran
 * - resize debounced
 * - JAMAIS d'écriture sur clientWidth/clientHeight (lecture seule)
 */
(function () {
  const DPR = Math.max(1, Math.min(window.devicePixelRatio || 1, 2));
  let raf, w = 0, h = 0, ctx, cvs, stars = [];
  const N = 120; // nombre d'étoiles

  function ensureCanvas(){
    cvs = document.getElementById('stars');
    if(!cvs){
      cvs = document.createElement('canvas');
      cvs.id = 'stars';
      // taille CSS (pas clientWidth!)
      cvs.style.position = 'fixed';
      cvs.style.inset = '0';
      cvs.style.pointerEvents = 'none';
      cvs.style.zIndex = '0';
      document.body.appendChild(cvs);
    }
    ctx = cvs.getContext('2d');
  }

  function resize(){
    const cssW = window.innerWidth;
    const cssH = window.innerHeight;
    // Dimension "bitmap" pour HDPI
    cvs.width  = Math.floor(cssW * DPR);
    cvs.height = Math.floor(cssH * DPR);
    // Dimension CSS (affichage)
    cvs.style.width  = cssW + 'px';
    cvs.style.height = cssH + 'px';
    ctx.setTransform(DPR, 0, 0, DPR, 0, 0);
    w = cssW; h = cssH;
  }

  function initStars(){
    stars = Array.from({length: N}, () => ({
      x: Math.random() * w,
      y: Math.random() * h,
      r: Math.random() * 1.2 + 0.3,
      a: Math.random() * Math.PI * 2,
      s: 0.2 + Math.random() * 0.8
    }));
  }

  function draw(){
    ctx.clearRect(0,0,w,h);
    for(const s of stars){
      s.a += 0.02 * s.s;
      const tw = (Math.sin(s.a) * 0.5 + 0.5); // twinkle 0..1
      ctx.globalAlpha = 0.35 + tw * 0.65;
      ctx.beginPath();
      ctx.arc(s.x, s.y, s.r, 0, Math.PI*2);
      ctx.fillStyle = '#fff';
      ctx.fill();
    }
    raf = requestAnimationFrame(draw);
  }

  function boot(){
    ensureCanvas();
    resize();
    initStars();
    cancelAnimationFrame(raf);
    draw();
  }

  let t;
  window.addEventListener('resize', () => { clearTimeout(t); t = setTimeout(boot, 120); });
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', boot, { once:true });
  else boot();
})();
