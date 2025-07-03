import React, { useState } from 'react';

export default function ContactForm() {
  const [form, setForm] = useState({ name: '', email: '', msg: '' });

  return (
    <form role="region" aria-label="Formulaire de contact" className="space-y-4" onSubmit={e => e.preventDefault()}>
      {Object.keys(form).map(k => (
        <div key={k}>
          <textarea
            rows={k === 'msg' ? 4 : 1}
            value={form[k]}
            onChange={e => setForm({ ...form, [k]: e.target.value })}
            required
            className="peer w-full p-4 border rounded focus:outline-none focus:ring focus:border-gold"
            placeholder={k === 'msg' ? 'Votre message...' : 'Votre ' + k}
          />
        </div>
      ))}
      <button type="submit" className="w-full bg-gold hover:bg-yellow text-luxeBlack font-bold py-3 rounded">
        ENVOYER
      </button>
    </form>
  );
}
