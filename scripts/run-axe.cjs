#!/usr/bin/env node
// scripts/run-axe.cjs
const { readFileSync } = require('fs');
const { JSDOM }        = require('jsdom');
const axeSource        = require('axe-core').source;

(async () => {
  try {
    // 1) Charge le HTML statique généré
    const html = readFileSync('dist/index.html', 'utf-8');

    // 2) Crée un JSDOM avec exécution de scripts autorisée
    const dom = new JSDOM(html, {
      runScripts: 'dangerously',
      resources: 'usable'
    });
    const { window } = dom;

    // 3) Injecte axe-core dans la fenêtre
    const scriptEl = window.document.createElement('script');
    scriptEl.textContent = axeSource;
    window.document.head.appendChild(scriptEl);

    // 4) Attend que tout soit chargé
    await new Promise(resolve => {
      if (window.document.readyState === 'complete') return resolve();
      window.addEventListener('load', resolve);
    });

    // 5) Lance l’audit via window.axe
    const results = await window.axe.run(window.document);

    // 6) Affiche les résultats
    console.log('\n🔍 Résultats a11y :');
    if (!results.violations.length) {
      console.log('✔ Aucun problème détecté par axe-core !');
    } else {
      for (const v of results.violations) {
        console.log(`\n• [${v.id}] ${v.help}`);
        v.nodes.forEach(n =>
          console.log('   - Élément :', n.target.join(', '))
        );
      }
    }
  } catch (err) {
    console.error('❌ Erreur lors de l’audit a11y :', err);
    process.exit(1);
  }
})();
