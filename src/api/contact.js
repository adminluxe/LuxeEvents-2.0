import { exec } from "child_process";

export async function POST(req) {
  try {
    const { name, email, message } = await req.json();

    const mail = `
To: contact@luxeevents.me
Subject: Nouvelle demande de devis LuxeEvents

Nom: ${name}
Email: ${email}
Message:
${message}
`.trim();

    const send = exec("sendmail contact@luxeevents.me");
    send.stdin.write(mail);
    send.stdin.end();

    return new Response(JSON.stringify({ ok: true }), { status: 200 });
  } catch (err) {
    console.error("Erreur d’envoi email:", err);
    return new Response(JSON.stringify({ error: "Erreur interne" }), { status: 500 });
  }
}
