#!/usr/bin/env bash
set -euo pipefail

echo "⚡ Démarrage du setup Performance & Scalabilité…"

# 1) Lighthouse CI
echo "1) Installation et config de Lighthouse CI…"
npm install --save-dev @lhci/cli
tee .lighthouserc.js > /dev/null << 'EOF'
module.exports = {
  ci: {
    collect: { url: ['http://localhost:4173'], startServerCommand: 'npm run dev', numberOfRuns: 3 },
    assert: { assertions: { 'categories:performance': ['error', { minScore: 0.9 }] } },
    upload: { target: 'temporary-public-storage' }
  }
};
EOF

# 2) Compression images
echo "2) Installation imagemin-cli…"
npm install --save-dev imagemin-cli imagemin-mozjpeg imagemin-pngquant
tee scripts/compress-images.sh > /dev/null << 'EOF'
#!/usr/bin/env bash
npx imagemin 'public/media/*.{jpg,png}' --plugin=pngquant --plugin=mozjpeg --out-dir=public/media
EOF
chmod +x scripts/compress-images.sh

# 3) CDN Cloudflare (exemple simple)
echo "3) Ajout du CDN Cloudflare dans index.html…"
sed -i -E "s#(<script type=\"module\" src=\")#\1https://cdnjs.cloudflare.com/ajax/libs/urijs/1.19.11/uri.min.js\", #g" dist/index.html

# 4) Monitoring basique
echo "4) Installation prom-client pour métriques…"
npm install prom-client express
tee src/metrics.js > /dev/null << 'EOF'
import express from 'express';
import client from 'prom-client';
const app = express();
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});
app.listen(3001, () => console.log('📊 Metrics running on http://localhost:3001/metrics'));
EOF

echo "✅ Setup Performance & Scalabilité prêt !  
→ Lance `npm run dev` et ensuite :  
   - `lhci autorun` pour lancer Lighthouse CI  
   - `./scripts/compress-images.sh` pour compresser tes médias  
   - Vérifie `http://localhost:3001/metrics` pour tes métriques  
"
