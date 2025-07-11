import React from 'react';
import useDarkMode from 'use-dark-mode';
export function useTheme() {
  const darkMode = useDarkMode(false, { storageKey: 'luxeevents-theme' });
  React.useEffect(() => {
    document.documentElement.setAttribute('data-theme', darkMode.value ? 'night' : 'day');
  }, [darkMode.value]);
  return darkMode;
}
