#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_cta_unify_final_${ts}"
mkdir -p "$BACKUP"

FILES=(
  "src/components/PrimaryCTA.jsx"
  "src/components/HeroSection.jsx"
  "src/components/ServicesSection.jsx"
  "src/components/NavBarLuxe.jsx"
  "src/components/NavBar.jsx"
  "src/components/CircularMenu.jsx"
  "src/components/TrustSection.jsx"
  "src/components/GallerySection.jsx"
  "src/components/FooterLuxe.jsx"
  "src/components/LuxuryCTA.jsx"
  "src/components/HeroSection.tsx"
)

echo "📦 Backup -> $BACKUP"
for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    mkdir -p "$BACKUP/$(dirname "$f")"
    cp -a "$f" "$BACKUP/$f"
  fi
done

echo "✍️  Rewrite: PrimaryCTA.jsx (single source of truth)"
mkdir -p src/components
cat > src/components/PrimaryCTA.jsx <<'EOF'
import React from "react";
import { Link } from "react-router-dom";

export const DEVIS_ROUTE = "/devis";
export const DEVIS_LABEL = "Demander un devis";

export default function PrimaryCTA({
  to = DEVIS_ROUTE,
  label = DEVIS_LABEL,
  variant = "default",
  className = "",
  children,
  title,
  ariaLabel,
  onClick,
}) {
  const base =
    "inline-flex items-center justify-center gap-2 select-none " +
    "transition-transform duration-200 active:scale-[0.99] focus:outline-none " +
    "focus-visible:ring-2 focus-visible:ring-yellow-400/60";

  const variants = {
    default:
      "px-5 py-3 rounded-full font-semibold text-black bg-gradient-to-r " +
      "from-yellow-300 via-yellow-400 to-yellow-300 shadow-lg shadow-yellow-400/20 " +
      "hover:shadow-yellow-400/30 hover:-translate-y-[1px]",
    hero:
      "px-7 py-4 rounded-full font-semibold text-black bg-gradient-to-r " +
      "from-yellow-300 via-yellow-400 to-yellow-300 shadow-xl shadow-yellow-400/25 " +
      "hover:shadow-yellow-400/35 hover:-translate-y-[1px]",
    mobile:
      "w-full px-6 py-4 rounded-full font-semibold text-black bg-gradient-to-r " +
      "from-yellow-300 via-yellow-400 to-yellow-300 shadow-xl shadow-yellow-400/25 " +
      "hover:shadow-yellow-400/35",
    nav:
      "px-4 py-2 rounded-full font-semibold text-black bg-yellow-400/90 " +
      "hover:bg-yellow-300 shadow-md shadow-yellow-400/20",
    inline:
      "px-0 py-0 rounded-none font-semibold text-yellow-300 hover:text-yellow-200 " +
      "underline underline-offset-4 decoration-yellow-400/60 hover:decoration-yellow-300/80",
    footerLink:
      "px-0 py-0 rounded-none font-medium text-white/80 hover:text-yellow-300 " +
      "transition-colors",
    icon:
      "w-10 h-10 rounded-full bg-black/60 text-white border border-white/10 " +
      "hover:border-yellow-400/40 hover:text-yellow-200 hover:bg-black/70",
  };

  const cls = [base, variants[variant] || variants.default, className]
    .filter(Boolean)
    .join(" ");

  const content = children ?? <span>{label}</span>;
  const t = title || label;
  const a = ariaLabel || label;

  return (
    <Link to={to} onClick={onClick} className={cls} title={t} aria-label={a}>
      {content}
    </Link>
  );
}
EOF

normalize_primary_import() {
  local f="$1"
  [ -f "$f" ] || return 0

  # If it imports PrimaryCTA, ensure it also imports DEVIS_ROUTE
  perl -i -pe '
    s/import\s+PrimaryCTA\s+from\s+["'\'']\.\/PrimaryCTA["'\'']\s*;/
      import PrimaryCTA, { DEVIS_ROUTE } from "\.\/PrimaryCTA";/gex;
    s/import\s+PrimaryCTA\s*,\s*\{\s*DEVIS_ROUTE\s*\}\s+from\s+["'\'']\.\/PrimaryCTA["'\'']\s*;/
      import PrimaryCTA, { DEVIS_ROUTE } from "\.\/PrimaryCTA";/gex;
  ' "$f"
}

ensure_primary_import() {
  local f="$1"
  [ -f "$f" ] || return 0

  # If file uses PrimaryCTA/DEVIS_ROUTE but doesn't import it, inject after first import line.
  if grep -qE '\bPrimaryCTA\b|\bDEVIS_ROUTE\b' "$f"; then
    if ! grep -qE 'from\s+["'\'']\.\/PrimaryCTA["'\'']' "$f"; then
      perl -0777 -i -pe 's/^(\s*import[^\n]*\n)/$1import PrimaryCTA, { DEVIS_ROUTE } from ".\/PrimaryCTA";\n\n/s' "$f"
    else
      normalize_primary_import "$f"
    fi
  fi
}

echo "🔧 Switch existing PrimaryCTA calls to DEVIS_ROUTE (Hero/Services/NavBarLuxe)"
for f in src/components/HeroSection.jsx src/components/ServicesSection.jsx src/components/NavBarLuxe.jsx; do
  if [ -f "$f" ]; then
    sed -i 's/to="\/devis"/to={DEVIS_ROUTE}/g' "$f"
    normalize_primary_import "$f"
    ensure_primary_import "$f"
  fi
done

echo "🔧 CircularMenu: Link(/devis) -> PrimaryCTA(icon)"
if [ -f src/components/CircularMenu.jsx ]; then
  perl -0777 -i -pe '
    s/<Link\s+to=["'\'']\/devis["'\'']\s+([^>]*)>(.*?)<\/Link>/
      <PrimaryCTA to={DEVIS_ROUTE} label="Devis" variant="icon" $1>$2<\/PrimaryCTA>/gs;
  ' src/components/CircularMenu.jsx
  ensure_primary_import src/components/CircularMenu.jsx
fi

echo "🔧 NavBar: LinkItem(/devis) -> PrimaryCTA(nav)"
if [ -f src/components/NavBar.jsx ]; then
  perl -0777 -i -pe '
    s/<LinkItem\b([^>]*?)href=["'\'']\/devis["'\'']([^>]*)>.*?<\/LinkItem>/
      <PrimaryCTA to={DEVIS_ROUTE} label="Devis" variant="nav" \/>/gs;
    s/href=["'\'']\/devis["'\'']/to={DEVIS_ROUTE}/g;
  ' src/components/NavBar.jsx
  ensure_primary_import src/components/NavBar.jsx
fi

echo "🔧 TrustSection: a(/devis) -> PrimaryCTA(default)"
if [ -f src/components/TrustSection.jsx ]; then
  perl -0777 -i -pe '
    s/<a\b([^>]*?)href=["'\'']\/devis["'\'']([^>]*)>.*?<\/a>/
      <PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis" variant="default" \/>/gs;
  ' src/components/TrustSection.jsx
  ensure_primary_import src/components/TrustSection.jsx
fi

echo "🔧 GallerySection: a(/devis) -> PrimaryCTA(inline)"
if [ -f src/components/GallerySection.jsx ]; then
  perl -0777 -i -pe '
    s/<a\b([^>]*?)href=["'\'']\/devis["'\'']([^>]*)>.*?<\/a>/
      <PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis →" variant="inline" \/>/gs;
  ' src/components/GallerySection.jsx
  ensure_primary_import src/components/GallerySection.jsx
fi

echo "🔧 FooterLuxe: Link(/devis) -> PrimaryCTA(footerLink)"
if [ -f src/components/FooterLuxe.jsx ]; then
  perl -0777 -i -pe '
    s/<Link\s+to=["'\'']\/devis["'\'']([^>]*)>.*?<\/Link>/
      <PrimaryCTA to={DEVIS_ROUTE} label="Demande de devis" variant="footerLink" \/>/gs;
  ' src/components/FooterLuxe.jsx
  ensure_primary_import src/components/FooterLuxe.jsx
fi

echo "🔧 LuxuryCTA: make it a wrapper around PrimaryCTA (no /devis inside)"
if [ -f src/components/LuxuryCTA.jsx ]; then
  cat > src/components/LuxuryCTA.jsx <<'EOF'
import React from "react";
import PrimaryCTA from "./PrimaryCTA";

export default function LuxuryCTA(props) {
  return <PrimaryCTA {...props} />;
}
EOF
fi

echo "🧽 Optional: HeroSection.tsx (if present) - ensure no legacy hardcoded /devis"
if [ -f src/components/HeroSection.tsx ]; then
  sed -i 's/to="\/devis"/to={DEVIS_ROUTE}/g' src/components/HeroSection.tsx || true
  ensure_primary_import src/components/HeroSection.tsx
fi

echo "✅ Done. Now check remaining hardcoded /devis (excluding backups) :"
echo "----"
grep -RIn \
  --exclude-dir=node_modules --exclude-dir=dist --exclude='*.bak*' \
  -E 'href=["'\'']\/devis["'\'']|to=["'\'']\/devis["'\'']' \
  src/components \
  | head -n 200 || true
echo "----"
echo "If output is empty => 100% clean."
