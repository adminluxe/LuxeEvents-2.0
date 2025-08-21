export default function Breadcrumbs({ items = [] }) {
  return (
    <nav aria-label="Fil d'ariane" className="text-sm text-white/80 my-4">
      <ol className="flex flex-wrap items-center gap-1">
        {items.map((it, i) => (
          <li key={i} className="flex items-center gap-1">
            {i > 0 && <span className="opacity-60">/</span>}
            {it.href ? (
              <a href={it.href} className="hover:underline decoration-yellow-400 underline-offset-4">
                {it.label}
              </a>
            ) : (
              <span className="text-yellow-400">{it.label}</span>
            )}
          </li>
        ))}
      </ol>
    </nav>
  );
}
