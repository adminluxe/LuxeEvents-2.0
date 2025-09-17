const nodemailer = require('nodemailer');
const https = require('https');

// read JSON body safely
async function readJson(req){
  try { if (req.body && typeof req.body === 'object') return req.body; } catch {}
  const chunks=[]; for await (const ch of req) chunks.push(ch);
  try { return JSON.parse(Buffer.concat(chunks).toString('utf8')||''); } catch { return {}; }
}

function corsHeaders(origin, allowed){
  const list = (allowed||'').split(',').map(s=>s.trim()).filter(Boolean);
  const allow = list.includes(origin) ? origin : (list[0] || '*');
  return {
    'Access-Control-Allow-Origin': allow,
    'Vary': 'Origin',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization'
  };
}

async function verifyTurnstile(token, ip){
  const secret = process.env.TURNSTILE_SECRET;
  if (!secret) return { ok:true };
  if (!token) return { ok:false, error:'missing_turnstile_token' };

  const data = new URLSearchParams({ secret, response: token });
  if (ip) data.append('remoteip', ip);

  const res = await fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
    method: 'POST', body: data,
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
  }).catch(()=>null);

  if (!res) return { ok:false, error:'turnstile_network_error' };
  const j = await res.json().catch(()=>null);
  return j && j.success ? { ok:true } : { ok:false, error:'turnstile_failed', detail:j };
}

module.exports = async (req, res) => {
  const origin = req.headers.origin || '';
  const headers = corsHeaders(origin, process.env.ALLOWED_ORIGINS);
  for (const [k,v] of Object.entries(headers)) res.setHeader(k,v);

  if (req.method === 'OPTIONS') { res.statusCode = 204; return res.end(); }
  if (req.method !== 'POST') { res.statusCode = 405; return res.end('Method Not Allowed'); }

  const data = await readJson(req);
  const { name, email, phone, date, topic, budget, message, page, source, website, turnstileToken } = data || {};

  // honeypot
  if (website && String(website).trim()) {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json; charset=utf-8');
    return res.end(JSON.stringify({ ok:true, spam:true }));
  }

  if (!name || !email || !message) {
    res.statusCode = 400;
    return res.end(JSON.stringify({ ok:false, error:'missing_fields', need:['name','email','message'] }));
  }

  // Turnstile (optionnel)
  const ip = req.headers['x-forwarded-for']?.split(',')[0]?.trim();
  const tsv = await verifyTurnstile(turnstileToken, ip);
  if (!tsv.ok) {
    res.statusCode = 400;
    return res.end(JSON.stringify({ ok:false, error: tsv.error || 'turnstile_error', detail: tsv.detail || null }));
  }

  // SMTP config
  const host = process.env.SMTP_HOST;
  const port = parseInt(process.env.SMTP_PORT || '587', 10);
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASS;
  const to   = process.env.CONTACT_RECIPIENT || process.env.MAIL_TO || user;
  const from = process.env.MAIL_FROM || (user ? `"LuxeEvents" <${user}>` : undefined);

  if (!host || !port || !to) {
    res.statusCode = 500;
    return res.end(JSON.stringify({ ok:false, error:'smtp_env_missing' }));
  }

  const transporter = nodemailer.createTransport({
    host, port, secure: (port === 465),
    auth: (user && pass) ? { user, pass } : undefined
  });

  const subject = `Demande de contact – ${name || email}`;
  const text = [
    `Nom: ${name}`,
    `Email: ${email}`,
    `Téléphone: ${phone || '-'}`,
    `Date: ${date || '-'}`,
    `Sujet: ${topic || '-'}`,
    `Budget: ${budget || '-'}`,
    `Page: ${page || '-'}`,
    `Source: ${source || '-'}`,
    '',
    'Message:',
    message || '-'
  ].join('\n');

  const log = {
    ip, at: new Date().toISOString(),
    name, email, phone, date, topic, budget, page, source
  };

  try{
    if (process.env.SMTP_DRY_RUN === "1") {
      res.setHeader('Content-Type','application/json; charset=utf-8');
      res.statusCode = 200;
      return res.end(JSON.stringify({ ok:true, dry_run:true }));
    }
    await transporter.verify().catch(()=>{});
    await transporter.sendMail({
      from, to, replyTo: email, subject, text,
      attachments: [{ filename:'contact.json', content: Buffer.from(JSON.stringify(log,null,2),'utf8') }]
    });
    res.setHeader('Content-Type','application/json; charset=utf-8');
    res.statusCode = 200;
    res.end(JSON.stringify({ ok:true }));
  }catch(err){
    res.setHeader('Content-Type','application/json; charset=utf-8');
    res.statusCode = 502;
    res.end(JSON.stringify({ ok:false, error:'smtp_send_failed', detail:String(err && err.message || err) }));
  }
};
