import React, { useState } from "react";
import Modal from "react-modal";
import { useForm } from "react-hook-form";
import Button from "./ui/Button";

Modal.setAppElement("#root");

export default function NewsletterPopup() {
  const url = import.meta.env.VITE_NEWSLETTER_URL
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
        <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <input {...register("email")} type="email" placeholder="Votre email" className="w-full border px-3 py-2 rounded"/>
          <Button type="submit">S’inscrire</Button>
        </form>
      </Modal>
    </>
  );
}
