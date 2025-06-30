let currentSlide = 0;
const slides = document.querySelectorAll('.carrousel-slide');
const totalSlides = slides.length;

document.querySelector('.carrousel-next').addEventListener('click', () => {
  if (currentSlide < totalSlides - 1) {
    currentSlide++;
  } else {
    currentSlide = 0;
  }
  updateSlidePosition();
});

document.querySelector('.carrousel-prev').addEventListener('click', () => {
  if (currentSlide > 0) {
    currentSlide--;
  } else {
    currentSlide = totalSlides - 1;
  }
  updateSlidePosition();
});

function updateSlidePosition() {
  const slideWidth = slides[0].clientWidth;
  document.querySelector('.carrousel-wrapper').style.transform = `translateX(-${currentSlide * slideWidth}px)`;
}
