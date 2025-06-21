import React, { useEffect, useState } from "react";
import Slider from "react-slick";
import { useTranslation } from "react-i18next";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

export default function EventSlider() {
  const { t } = useTranslation();
  const [events, setEvents] = useState([]);

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_URL}/events`)
      .then(res => res.json())
      .then(data => setEvents(data))
      .catch(console.error);
  }, []);

  if (!events.length) return <p className="text-center">{t("events.loading")}</p>;

  return (
    <section className="px-6">
      <h2 className="text-3xl font-semibold text-center mb-4">{t("events.title")}</h2>
      <Slider dots infinite slidesToShow={3} slidesToScroll={1} autoplay autoplaySpeed={4000}>
        {events.map(evt => (
          <div key={evt.id} className="p-2">
            <div className="bg-white rounded-lg shadow p-4">
              <h3 className="font-bold text-lg mb-2">{evt.name}</h3>
              <p className="text-sm mb-1">{new Date(evt.date).toLocaleDateString()}</p>
              <p>{evt.description.substring(0, 100)}…</p>
            </div>
          </div>
        ))}
      </Slider>
    </section>
  );
}
