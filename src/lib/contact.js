export async function sendContact(payload){
  const base = (import.meta.env.VITE_BACKEND_URL || "").replace(/\/+$/,"");
  const override = (import.meta.env.VITE_CONTACT_ENDPOINT || "").trim();
  const url = override || (base ? base + "/api/contact" : "/api/contact");

  const res = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  });

  if (!res.ok) {
    let msg = "";
    try { msg = await res.text(); } catch {}
    throw new Error(msg || `HTTP ${res.status}`);
  }
  try { return await res.json(); } catch { return { ok:true }; }
}
