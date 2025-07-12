import Layout from "@/components/Layout.jsx"
import { useForm } from "react-hook-form"
import Button from "@/components/Button"
import { useTranslation } from "react-i18next"

export default function Quote() {
  const { t } = useTranslation()
  const { register, handleSubmit } = useForm()
  const onSubmit = data => alert(JSON.stringify(data, null, 2))

  return (
    <Layout title={t("quote.title")}>
      <section className="max-w-xl mx-auto py-section-vertical">
        <h1 className="text-h1 mb-6">{t("quote.mainTitle")}</h1>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <label className="block mb-1">{t("quote.name")}</label>
            <input {...register("name")} className="w-full border rounded p-2" required />
          </div>
          <div>
            <label className="block mb-1">{t("quote.email")}</label>
            <input {...register("email")} type="email" className="w-full border rounded p-2" required />
          </div>
          <div>
            <label className="block mb-1">{t("quote.details")}</label>
            <textarea {...register("details")} className="w-full border rounded p-2" rows="5" />
          </div>
          <Button type="submit" variant="premium">{t("quote.submit")}</Button>
        </form>
      </section>
    </Layout>
  )
}
