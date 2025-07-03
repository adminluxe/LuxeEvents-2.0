import React, { useEffect, useState } from 'react';

export default function LocaleTime() {
  const [time, setTime] = useState('');
  useEffect(() => {
    navigator.geolocation.getCurrentPosition(pos => {
      const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
      setTime(new Intl.DateTimeFormat('default', { timeStyle: 'short', timeZone: tz }).format(new Date()));
    });
  }, []);
  return <div className="mt-2 text-sm">Heure locale : {time}</div>;
}
