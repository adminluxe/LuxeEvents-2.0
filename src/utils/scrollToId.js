function isScrollable(el) {
  if (!el || el === document.body) return false;
  const st = window.getComputedStyle(el);
  const oy = st.overflowY;
  return (oy === "auto" || oy === "scroll") && el.scrollHeight > el.clientHeight + 2;
}

function findScrollParent(el) {
  let p = el?.parentElement || null;
  while (p) {
    if (isScrollable(p)) return p;
    p = p.parentElement;
  }
  return null;
}

function disableSnapTemporarily(container, ms = 450) {
  if (!container) return () => {};
  const st = window.getComputedStyle(container);
  const snap = st.scrollSnapType;
  if (!snap || snap === "none") return () => {};

  const prev = container.style.scrollSnapType;
  container.style.scrollSnapType = "none";

  const t = setTimeout(() => {
    container.style.scrollSnapType = prev || "";
  }, ms);

  return () => clearTimeout(t);
}

export function scrollToId(id, { offset = 72, behavior = "smooth" } = {}) {
  if (!id) return false;

  const safeId = (() => {
    try { return decodeURIComponent(id); } catch { return id; }
  })();

  const el = document.getElementById(safeId);
  if (!el) return false;

  const container = findScrollParent(el);

  // --- Case 1: container scrollable (common with snap layouts)
  if (container) {
    const cleanup = disableSnapTemporarily(container, 500);

    const cRect = container.getBoundingClientRect();
    const eRect = el.getBoundingClientRect();

    const currentTop = container.scrollTop;
    const targetTop = currentTop + (eRect.top - cRect.top) - offset;

    container.scrollTo({ top: targetTop, behavior });
    setTimeout(cleanup, 520);
    return true;
  }

  // --- Case 2: normal window scroll
  const cleanup = disableSnapTemporarily(document.documentElement, 500);

  el.scrollIntoView({ behavior, block: "start" });
  setTimeout(() => window.scrollBy({ top: -offset, left: 0, behavior: "instant" }), 0);
  setTimeout(cleanup, 520);
  return true;
}
