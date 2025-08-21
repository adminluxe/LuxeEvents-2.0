import { lazy, Suspense } from "react";

// Universel Vite/Next : si le composant n'existe pas, on n'explose pas au build.
const Inner = lazy(() =>
  import("./CircularMenu.jsx")
    .then(mod => ({ default: mod.default || (() => null) }))
    .catch(() => ({ default: () => null }))
);

export default function CircularMenuDock() {
  return (
    <div
      className="fixed z-50 pointer-events-auto"
      style={{
        right: "max(16px, env(safe-area-inset-right))",
        bottom: "max(16px, env(safe-area-inset-bottom))"
      }}
    >
      <Suspense fallback={null}>
        <Inner />
      </Suspense>
    </div>
  );
}
