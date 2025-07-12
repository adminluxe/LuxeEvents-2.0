import Layout from "@/components/Layout.jsx"
import { useTranslation } from "react-i18next"

export default function About() {
  const { t } = useTranslation()
  return (
    <Layout title={t("about.title")}>
      <section className="prose mx-auto py-section-vertical">
        <h1 className="text-h1 text-gradient">{t("about.mainTitle")}</h1>
        <p>{t("about.paragraph1")}</p>
        <p>{t("about.paragraph2")}</p>
        <p>{t("about.paragraph3")}</p>
      </section>
    </Layout>
  )
}
