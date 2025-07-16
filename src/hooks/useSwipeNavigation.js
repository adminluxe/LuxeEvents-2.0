import { useEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';

export default function useSwipeNavigation() {
  const navigate = useNavigate();
  const location = useLocation();
  const routes = ['/', '/media', '/services', '/demande-de-devis'];

  useEffect(() => {
    let touchStartX = 0;

    const handleTouchStart = (e) => {
      touchStartX = e.touches[0].clientX;
    };

    const handleTouchEnd = (e) => {
      const touchEndX = e.changedTouches[0].clientX;
      const deltaX = touchEndX - touchStartX;

      const currentIndex = routes.indexOf(location.pathname);

      if (deltaX > 50 && currentIndex > 0) {
        navigate(routes[currentIndex - 1]);
      } else if (deltaX < -50 && currentIndex < routes.length - 1) {
        navigate(routes[currentIndex + 1]);
      }
    };

    window.addEventListener('touchstart', handleTouchStart);
    window.addEventListener('touchend', handleTouchEnd);
    return () => {
      window.removeEventListener('touchstart', handleTouchStart);
      window.removeEventListener('touchend', handleTouchEnd);
    };
  }, [location, navigate]);
}
