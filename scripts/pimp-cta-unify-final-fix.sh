#!/usr/bin/env bash
set -euo pipefail

cd "${1:-.}"

latest_backup="$(ls -1d _backup_cta_unify_final_* 2>/dev/null | sort | tail -n 1 || true)"
if [ -z "${latest_backup}" ]; then
  echo "❌ Aucun backup _backup_cta_unify_final_* trouvé. Stop."
  exit 1
fi

echo "🧯 Restore depuis: ${latest_backup}"
# restore uniquement ce qui existe dans le backup (fichiers patchés)
( cd "${latest_backup}" && find . -type f -print0 ) | while IFS= read -r -d '' f; do
  src="${latest_backup}/${f#./}"
  dst="./${f#./}"
  mkdir -p "$(dirname "$dst")"
  cp -a "$src" "$dst"
done

echo "✍️  (Re)write PrimaryCTA.jsx (single source of truth)"
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

needs_primary_import() {
  local f="$1"
  [ -f "$f" ] || return 1
  grep -qE '\bPrimaryCTA\b|\bDEVIS_ROUTE\b' "$f"
}

has_primary_import() {
  local f="$1"
  grep -qE 'from\s+["'\'']\./PrimaryCTA["'\'']' "$f"
}

normalize_primary_import() {
  local f="$1"
  # 1) import PrimaryCTA from "./PrimaryCTA";  -> import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";
  sed -i \
    -e 's#^[[:space:]]*import[[:space:]]\+PrimaryCTA[[:space:]]\+from[[:space:]]\+"\./PrimaryCTA";#import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";#' \
    -e "s#^[[:space:]]*import[[:space:]]\\+PrimaryCTA[[:space:]]\\+from[[:space:]]\\+'\\./PrimaryCTA';#import PrimaryCTA, { DEVIS_ROUTE } from \"./PrimaryCTA\";#" \
    "$f" || true

  # 2) import PrimaryCTA, { ... } from "./PrimaryCTA"; -> ensure DEVIS_ROUTE is present
  if grep -qE 'import[[:space:]]+PrimaryCTA,[[:space:]]*\{[^}]*\}[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA["'\'']' "$f"; then
    if ! grep -qE 'import[[:space:]]+PrimaryCTA,[[:space:]]*\{[^}]*DEVIS_ROUTE[^}]*\}[[:space:]]+from[[:space:]]+["'\'']\./PrimaryCTA["'\'']' "$f"; then
      # ajoute DEVIS_ROUTE au début de la liste { ... }
      sed -i 's#\(import[[:space:]]\+PrimaryCTA,[[:space:]]*\{\)#\1 DEVIS_ROUTE,#' "$f"
    fi
  fi
}

inject_primary_import() {
  local f="$1"
  needs_primary_import "$f" || return 0

  if has_primary_import "$f"; then
    normalize_primary_import "$f"
    return 0
  fi

  # Inject after the initial import block
  awk '
    BEGIN{inserted=0}
    {
      if (!inserted) {
        # still in import block
        if ($0 ~ /^[[:space:]]*import[[:space:]]/) {
          print $0
          next
        } else {
          print "import PrimaryCTA, { DEVIS_ROUTE } from \"./PrimaryCTA\";"
          print ""
          inserted=1
        }
      }
      print $0
    }
    END{
      if (!inserted) {
        print "import PrimaryCTA, { DEVIS_ROUTE } from \"./PrimaryCTA\";"
      }
    }
  ' "$f" > "$f.__tmp__" && mv "$f.__tmp__" "$f"
}

swap_devis_literals() {
  local f="$1"
  [ -f "$f" ] || return 0
  sed -i \
    -e 's#to="/devis"#to={DEVIS_ROUTE}#g' \
    -e 's#href="/devis"#href={DEVIS_ROUTE}#g' \
    -e "s#to='/devis'#to={DEVIS_ROUTE}#g" \
    -e "s#href='/devis'#href={DEVIS_ROUTE}#g" \
    "$f" || true
}

FILES=(
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

echo "🔁 Replace literals (/devis) -> DEVIS_ROUTE (safe sed)"
for f in "${FILES[@]}"; do
  swap_devis_literals "$f"
done

echo "🧩 CircularMenu: Link(/devis) -> PrimaryCTA(icon)"
if [ -f src/components/CircularMenu.jsx ]; then
  # cas le plus courant (emoji 📝)
  sed -i 's#<Link to={DEVIS_ROUTE} className={itemCls} title="Devis">📝</Link>#<PrimaryCTA to={DEVIS_ROUTE} label="Devis" variant="icon" className={itemCls} title="Devis">📝</PrimaryCTA>#g' src/components/CircularMenu.jsx || true
  sed -i 's#<Link to="/devis" className={itemCls} title="Devis">📝</Link>#<PrimaryCTA to={DEVIS_ROUTE} label="Devis" variant="icon" className={itemCls} title="Devis">📝</PrimaryCTA>#g' src/components/CircularMenu.jsx || true
  inject_primary_import src/components/CircularMenu.jsx
fi

echo "🧩 FooterLuxe: Link(/devis) -> PrimaryCTA(footerLink)"
if [ -f src/components/FooterLuxe.jsx ]; then
  sed -i 's#<Link to={DEVIS_ROUTE}[^>]*>[^<]*</Link>#<PrimaryCTA to={DEVIS_ROUTE} label="Demande de devis" variant="footerLink" />#g' src/components/FooterLuxe.jsx || true
  sed -i 's#<Link to="/devis"[^>]*>[^<]*</Link>#<PrimaryCTA to={DEVIS_ROUTE} label="Demande de devis" variant="footerLink" />#g' src/components/FooterLuxe.jsx || true
  inject_primary_import src/components/FooterLuxe.jsx
fi

echo "🧩 TrustSection: CTA /devis -> PrimaryCTA(default)"
if [ -f src/components/TrustSection.jsx ]; then
  # remplace un <a ... href=/devis ...>...</a> par PrimaryCTA (best effort)
  sed -i 's#<a[^>]*href={DEVIS_ROUTE}[^>]*>[^<]*</a>#<PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis" variant="default" />#g' src/components/TrustSection.jsx || true
  sed -i 's#<a[^>]*href="/devis"[^>]*>[^<]*</a>#<PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis" variant="default" />#g' src/components/TrustSection.jsx || true
  inject_primary_import src/components/TrustSection.jsx
fi

echo "🧩 GallerySection: CTA /devis -> PrimaryCTA(inline)"
if [ -f src/components/GallerySection.jsx ]; then
  sed -i 's#<a[^>]*href={DEVIS_ROUTE}[^>]*>[^<]*</a>#<PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis →" variant="inline" />#g' src/components/GallerySection.jsx || true
  sed -i 's#<a[^>]*href="/devis"[^>]*>[^<]*</a>#<PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis →" variant="inline" />#g' src/components/GallerySection.jsx || true
  inject_primary_import src/components/GallerySection.jsx
fi

echo "🧩 Hero/Services/NavBarLuxe: ensure import + DEVIS_ROUTE"
for f in src/components/HeroSection.jsx src/components/ServicesSection.jsx src/components/NavBarLuxe.jsx; do
  [ -f "$f" ] || continue
  # si PrimaryCTA est utilisé et qu'on a to={DEVIS_ROUTE}, inject import
  inject_primary_import "$f"
  normalize_primary_import "$f"
done

echo "🧩 LuxuryCTA: wrapper clean (no /devis inside)"
if [ -f src/components/LuxuryCTA.jsx ]; then
  cat > src/components/LuxuryCTA.jsx <<'EOF'
import React from "react";
import PrimaryCTA from "./PrimaryCTA";

export default function LuxuryCTA(props) {
  return <PrimaryCTA {...props} />;
}
EOF
fi

echo "🧪 Check: remaining hardcoded /devis in src/components (exclude backups)"
echo "----"
grep -RIn \
  --exclude-dir=node_modules --exclude-dir=dist --exclude='*.bak*' \
  -E 'href=["'\'']\/devis["'\'']|to=["'\'']\/devis["'\'']' \
  src/components \
  | head -n 200 || true
echo "----"
echo "✅ If empty => 100% clean."
