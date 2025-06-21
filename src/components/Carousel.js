import Slider from 'react-slick';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
export default function Carousel({ items }) {
  const settings = { dots: true, infinite: true, slidesToShow: 1, slidesToScroll: 1 };
  return (
    <Slider {...settings}>
      {items.map((it,i) => (
        <div key={i} className="p-4">
          <img src={it.src} alt={it.alt} className="mx-auto rounded-lg"/>
          <p className="mt-2 text-center">{it.caption}</p>
        </div>
      ))}
    </Slider>
  );
}
