#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Démarrage du Launch Campaign Combo…"

# 1) Génération landing “Coming Soon”
echo "1) Génération landing “Coming Soon”"
mkdir -p src/pages
cat > src/pages/Teaser.jsx << 'EOF'
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
EOF

# 2) Scaffold drip emails
echo "2) Scaffold drip emails"
mkdir -p scripts/emails
cat > scripts/emails/drip.js << 'EOF'
// scripts/emails/drip.js
import SibApiV3Sdk from 'sib-api-v3-sdk';
const api = new SibApiV3Sdk.TransactionalEmailsApi();
SibApiV3Sdk.ApiClient.instance.authentications['api-key'].apiKey = process.env.SIB_API_KEY;
export default async function sendDrip(to, name) {
  await api.sendTransacEmail({
    sender: { name: 'LuxeEvents', email: 'no-reply@luxeevents.com' },
    to: [{ email: to, name }],
    templateId: 5,
    params: {}
  });
}
EOF

echo "→ Création du workflow GitHub Actions pour le Drip"
mkdir -p .github/workflows
cat > .github/workflows/drip.yml << 'EOF'
name: Drip Email
on:
  schedule:
    - cron: '0 9 * * *'
jobs:
  drip:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'
      - run: npm install
      - run: node scripts/emails/drip.js
        env:
          SIB_API_KEY: \${{ secrets.SIB_API_KEY }}
EOF

# 3) Inject Google & LinkedIn Ads
echo "3) Inject Google & LinkedIn Ads"
if [ ! -f public/index.html ]; then
  echo "⚠ public/index.html introuvable, passe en src/index.html si tu utilises un autre setup"
fi
cat >> public/index.html << 'EOF'
<!-- Google Ads Conversion -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-XXXXX"></script>
<script>
  window.dataLayer=window.dataLayer||[];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'AW-XXXXX');
</script>

<!-- LinkedIn Insight Tag -->
<script type="text/javascript">
  _linkedin_partner_id = "123456";
  window._linkedin_data_partner_ids = window._linkedin_data_partner_ids || [];
  window._linkedin_data_partner_ids.push(_linkedin_partner_id);
</script>
<script src="https://snap.licdn.com/li.lms-analytics/insight.min.js" async></script>
<noscript><img height="1" width="1" style="display:none" alt=""
 src="https://dc.ads.linkedin.com/collect/?pid=123456&fmt=gif" /></noscript>
EOF

# 4) Retargeting & Social Pixel
echo "4) Script retargeting visiteurs teaser"
mkdir -p src/utils
cat > src/utils/teaserPixel.js << 'EOF'
// src/utils/teaserPixel.js
import { useEffect } from 'react';

export function useTeaserPixel() {
  useEffect(() => {
    if (window.location.pathname === '/teaser') {
      /* Facebook Pixel */
      !(function(f,b,e,v,n,t,s){
        if(f.fbq)return;n=f.fbq=function(){n.callMethod?
          n.callMethod.apply(n,arguments):n.queue.push(arguments)};
        if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
        n.queue=[];t=b.createElement(e);t.async=!0;
        t.src=v;s=b.getElementsByTagName(e)[0];
        s.parentNode.insertBefore(t,s);
      })(window, document,'script','https://connect.facebook.net/en_US/fbevents.js');
      fbq('init', 'YOUR_FB_PIXEL_ID');
      fbq('track', 'PageView');
    }
  }, []);
}
EOF

# 5) Reporting Automation
echo "5) Automatiser KPI & Reporting"
mkdir -p scripts
cat > scripts/report.js << 'EOF'
// scripts/report.js
import fetch from 'node-fetch';
(async function(){
  await fetch(
    'https://analytics.google.com/mp/collect?measurement_id=G-XXXX&api_secret=' +
    process.env.GA_SECRET,
    { method: 'POST', body: JSON.stringify({/* payload minimal */}) }
  );
  console.log('KPI envoyé');
})();
EOF

echo "→ Création du workflow GitHub Actions pour le Reporting"
cat > .github/workflows/report.yml << 'EOF'
name: Monthly KPI Report
on:
  schedule:
    - cron: '0 8 1 * *'
jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'
      - run: npm install
      - run: node scripts/report.js
        env:
          GA_SECRET: \${{ secrets.GA_SECRET }}
EOF

echo "✅ Launch Campaign Combo prêt !"
echo "→ Remplace les placeholders (IDs, keys…) et commit → ta CI gère tout. 🚀"
