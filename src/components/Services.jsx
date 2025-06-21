import React from "react";
import { Card, CardContent } from "@/components/ui/card";
import { useTranslation } from "react-i18next";

const services = ["organisation", "scenographie", "catering"].map(key => ({
  key,
  title: key.charAt(0).toUpperCase() + key.slice(1),
  description: `services.${key}.desc`
}));

export default function Services() {
  const { t } = useTranslation();
  return (
    <section className="px-6">
      <h2 className="text-3xl font-semibold text-center mb-8">{t("services.title")}</h2>
      <div className="grid gap-6 md:grid-cols-3">
        {services.map(s => (
          <Card key={s.key} className="p-4">
            <CardContent>
              <h3 className="text-xl font-bold mb-2">{t(s.title)}</h3>
              <p>{t(s.description)}</p>
            </CardContent>
          </Card>
        ))}
      </div>
    </section>
  );
}
