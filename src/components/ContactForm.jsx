import { useState } from 'react'
export default function ContactForm(){
  const [f,setF]=useState({name:'',email:'',msg:''})
  return (
    <div className="py-16 px-4 max-w-xl mx-auto bg-ivory rounded-lg shadow-lg">
      <h2 className="text-4xl font-serif mb-8 text-center">Contactez-nous</h2>
      <form onSubmit={e=>{e.preventDefault();alert('Envoyé !')}} className="space-y-6">
        {['name','email','msg'].map((k,i)=>(
          <div key={i} className="relative">
            <textarea id={k} rows={k==='msg'?4:1} value={f[k]} onChange={e=>setF({...f,[k]:e.target.value})} required className="peer w-full p-4 border rounded focus:outline-none focus:ring focus:border-gold"/>
            <label htmlFor={k} className="absolute left-4 top-4 text-gray-400 peer-focus:top-1 peer-focus:text-sm peer-focus:text-gold transition-all">{k==='msg'?'Votre message…':\`Votre \${k}\`}</label>
          </div>
        ))}
        <button type="submit" className="w-full bg-gold hover:bg-yellow text-luxeBlack font-bold py-3 rounded">ENVOYER</button>
      </form>
    </div>
  )
}
