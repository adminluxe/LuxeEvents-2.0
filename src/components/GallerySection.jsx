import React from "react";
import {useLang} from "../i18n/LangContext.jsx";
const thumbs = Array.from({length:8}, (_,i)=>i+1);
export default function GallerySection(){
  const {t} = useLang();
  return (
    <section className="lx-sec" id="gallery">
      <div className="lx-wrap">
        <h2 className="lx-title">{t("galleryTitle")}</h2>
        <div className="lx-gallery">
          {thumbs.map((n)=>(
            <div className="lx-card lx-pad" key={n}>
              <img loading="lazy" src={`/images/gallery/thumb${n}.png`} alt={`LuxeEvents ${n}`}
                   onError={(e)=>{ e.currentTarget.onerror=null; e.currentTarget.src=`/images/gallery/thumb${n}.webp`; }} />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
