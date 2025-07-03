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
