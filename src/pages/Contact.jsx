import React from 'react'
import { useInView } from "react-intersection-observer";
import { motion } from "framer-motion";
import { useInView } from "react-intersection-observer";
import { motion } from "framer-motion";
import { useForm } from 'react-hook-form'
import * as yup from "yup"
import { yupResolver } from "@hookform/resolvers/yup"
import Card from "../components/ui/Card"
import * as yup from "yup"
import { yupResolver } from "@hookform/resolvers/yup"
import Card from "../components/ui/Card"
import { ToastContainer, toast } from 'react-toastify'
import { useContact } from '../hooks/useContact'
import Button from '../components/ui/Button'
import 'react-toastify/dist/ReactToastify.css'

export default function Contact() {
  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });

  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });
  const schema = yup.object().shape({ name: yup.string().required(), email: yup.string().email().required(), subject: yup.string().required(), message: yup.string().required() });
  const { register, handleSubmit, reset, formState: { errors } } = useForm({ resolver: yupResolver(schema) });
  const { submit, loading, error } = useContact()

  const onSubmit = async data => {
    await submit(data)
    if (!error) {
      toast.success('Message envoyé !')
if(window.fbq) fbq('track','Lead');      _linkedin_data_partner_ids && _linkedin_data_partner_ids.forEach(pid => window.lintrk('track',{ conversion_id: pid, event: 'formSubmission' }));
      reset()
    } else {
      toast.error(error)
    }
  }

  return (<motion.div ref={ref} initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}}>
  (
    <motion.div ref={ref} initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}}>
    <Card className="mx-auto max-w-md p-6">
      <h2 className="text-2xl font-bold mb-4 text-center">Contactez-nous</h2>
      <form role="region" aria-label="Formulaire de contact" onSubmit={handleSubmit(onSubmit)} className="space-y-4">
        <input {...register("subject")} placeholder="Sujet" className="w-full border px-3 py-2 rounded" />
        {errors.subject && <p className="text-red-600 text-sm">{errors.subject.message}</p>}
        <input {...register("subject")} placeholder="Sujet" className="w-full border px-3 py-2 rounded" />
        <div className="text-sm text-red-600">{errors.subject?.message}</div>
    </motion.div>
