#!/usr/bin/env bash
set -euo pipefail

echo "🍸 Démarrage du setup Combo Tonton…"

# 1) Hero vidéo
echo "1) Intégration de public/hero-loop.mp4 dans Hero.jsx…"
read -p "⚠️ Place ton fichier video public/hero-loop.mp4 puis appuie sur Entrée…" _
# Remplace placeholder par video
sed -i '/<img .*hero.jpg/ {
  s|<img.*>|<video src="/hero-loop.mp4" autoPlay loop muted className="absolute inset-0 w-full h-full object-cover"/>|
}' src/components/landing/Hero.jsx

# 2) Formulaire Réservation + date-picker
echo "2) Installation react-datepicker et patch ReservationForm.jsx…"
npm install react-datepicker --save
sed -i '/import.*react-hook-form/a import DatePicker from "react-datepicker"\nimport "react-datepicker/dist/react-datepicker.css"' src/pages/ReservationForm.jsx
# Ajout du state date et remplacement de l’input date
perl -i -0777 -pe '
  s|const { register, handleSubmit, formState|const { register, handleSubmit, formState|s;
  s|<input\n              type="date".*>|<DatePicker selected={startDate} onChange={date => setStartDate(date)} className="w-full border px-3 py-2 rounded"/>\n            <input type="hidden" value={startDate} {...register("date")}/>|;
  s|export default function ReservationForm\(\) {|export default function ReservationForm() {\n  const [startDate, setStartDate] = React.useState(new Date())\n|;
' src/pages/ReservationForm.jsx

# 3) Pop-up Newsletter
echo "3) Installation react-modal et création NewsletterPopup.jsx…"
npm install react-modal --save
tee src/components/NewsletterPopup.jsx > /dev/null << 'EOF'
import React, { useState } from "react";
import Modal from "react-modal";
import { useForm } from "react-hook-form";
import Button from "./ui/Button";

Modal.setAppElement("#root");

export default function NewsletterPopup() {
  const [isOpen, setIsOpen] = useState(false);
  const { register, handleSubmit } = useForm();
  const onSubmit = data => {
    // TODO: ton endpoint Mailchimp / Sendinblue ici
    console.log("Inscrit :", data);
    setIsOpen(false);
  };
  return (
    <>
      <Button onClick={() => setIsOpen(true)}>📬 Newsletter</Button>
      <Modal
        isOpen={isOpen}
        onRequestClose={() => setIsOpen(false)}
        className="bg-white p-6 max-w-md mx-auto rounded shadow"
        overlayClassName="fixed inset-0 bg-black bg-opacity-50"
      >
        <h2 className="text-xl mb-4">Rejoignez notre Newsletter</h2>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <input {...register("email")} type="email" placeholder="Votre email" className="w-full border px-3 py-2 rounded"/>
          <Button type="submit">S’inscrire</Button>
        </form>
      </Modal>
    </>
  );
}
EOF

# 4) Intégration du bouton Newsletter dans le Header
echo "4) Ajout du bouton Newsletter dans Hero.jsx…"
sed -i '/<div className="text-center mt-8">/a \        <NewsletterPopup />' src/components/landing/Hero.jsx
sed -i '/import.*Hero/a import NewsletterPopup from "..\/components\/NewsletterPopup"' src/components/landing/Hero.jsx

echo "✅ Setup Combo Tonton terminé !"
echo "→ N’oublie pas de remplacer le TODO dans NewsletterPopup par ton endpoint réel."
echo "→ Relance le dev : npm run dev -- --host"
