---

### ✅ `deploy.sh`

```bash
#!/bin/bash
echo "📦 Installation des dépendances..."
pnpm install

echo "⚙️ Build Vite en cours..."
pnpm run build

echo "🚀 Déploiement vers Vercel (prod)..."
vercel --prod --yes
