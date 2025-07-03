// src/utils/retargeting.js
import { useEffect } from 'react';

const FB_PIXEL_ID = process.env.REACT_APP_FB_PIXEL_ID;
const LI_ID      = process.env.REACT_APP_LI_PARTNER_ID;

export function initPixels() {
  // Facebook Pixel
  if (FB_PIXEL_ID) {
    !(function(f,b,e,v,n,t,s){
      if(f.fbq)return;n=f.fbq=function(){n.callMethod?
        n.callMethod.apply(n,arguments):n.queue.push(arguments)};
      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
      n.queue=[];t=b.createElement(e);t.async=!0;
      t.src=v;s=b.getElementsByTagName(e)[0];
      s.parentNode.insertBefore(t,s);
    })(window, document,'script','https://connect.facebook.net/en_US/fbevents.js');
    fbq('init', FB_PIXEL_ID);
  }

  // LinkedIn Insight
  if (LI_ID) {
    window._linkedin_partner_id = LI_ID;
    window._linkedin_data_partner_ids = window._linkedin_data_partner_ids || [];
    window._linkedin_data_partner_ids.push(LI_ID);
    const l = document.createElement('script');
    l.src = 'https://snap.licdn.com/li.lms-analytics/insight.min.js';
    l.async = true;
    document.head.appendChild(l);
  }
}

export function resetPixels() {
  // Purge les pixels existants (utile en cas de changement d’ID ou de test)
  delete window.fbq;
  delete window._linkedin_partner_id;
  delete window._linkedin_data_partner_ids;
  console.log('✅ Pixels purgés, prêt pour un nouveau retargeting');
}

// Hook React pour lancer l’init uniquement sur la page Teaser
export function useRetargeting() {
  useEffect(() => {
    if (window.location.pathname === '/teaser') {
      initPixels();
      fbq && fbq('track', 'PageView');
    } else {
      resetPixels();
    }
  }, []);
}
