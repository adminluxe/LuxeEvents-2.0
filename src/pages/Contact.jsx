import React, { useState } from 'react';

export default function Contact() {
  const [form, setForm] = useState({ name:'', email:'', message:'' });
  const [status, setStatus] = useState('idle');

  const handleChange = e => setForm({...form,[e.target.name]:e.target.value});
  const handleSubmit = async e => {
    e.preventDefault();
    setStatus('sending');
    try {
      const res = await fetch('/api/contact', {
        method:'POST',
        headers:{ 'Content-Type':'application/json' },
        body: JSON.stringify(form)
      });
      if (res.ok) setStatus('sent');
      else throw new Error(await res.text());
    } catch(err) {
      console.error(err);
      setStatus('error');
    }
  };

  return (
    <main className="max-w-xl mx-auto p-4 font-sans">
      <h1 className="text-3xl font-bold text-purple-800 mb-6">Contactez-nous</h1>
      {status === 'sent' ? (
        <p className="text-green-600">Merci ! Nous vous répondrons sous 24 h.</p>
      ) : (
        <form onSubmit={handleSubmit} className="space-y-4">
          <input required name="name" placeholder="Votre nom" onChange={handleChange}
            className="w-full p-3 border rounded"/>
          <input required type="email" name="email" placeholder="Votre email" onChange={handleChange}
            className="w-full p-3 border rounded"/>
          <textarea required name="message" rows="5" placeholder="Votre message" onChange={handleChange}
            className="w-full p-3 border rounded"/>
          <button type="submit" disabled={status==='sending'}
            className="px-6 py-3 bg-purple-700 text-white rounded hover:bg-purple-800 transition">
            {status==='sending'?'Envoi…':'Envoyer'}
          </button>
          {status==='error' && <p className="text-red-600">Erreur, réessayez.</p>}
        </form>
      )}
    </main>
  );
}
