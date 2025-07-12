import { useEffect } from 'react';
import Rellax from 'rellax';
export function useParallax(selector, speed = -2) {
  useEffect(() => {
    const rellax = new Rellax(selector, { speed, center: true });
    return () => rellax.destroy();
  }, [selector, speed]);
}
