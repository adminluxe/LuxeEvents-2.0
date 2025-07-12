import Layout from "@/components/Layout.jsx"
import Carousel from "@/components/Carousel"
import { useTranslation } from "react-i18next"

const images = [
  "/assets/media/gallery/1.jpg",
  "/assets/media/gallery/2.jpg",
  "/assets/media/gallery/3.jpg",
]

export default function Gallery() {
  const { t } = useTranslation()
  return (
    <Layout title={t("gallery.title")}>
      <section className="py-section-vertical">
        <h1 className="text-h1 text-center mb-8">{t("gallery.mainTitle")}</h1>
        <div className="max-w-4xl mx-auto">
          <Carousel images={images} />
        </div>
      </section>
    </Layout>
  )
}
