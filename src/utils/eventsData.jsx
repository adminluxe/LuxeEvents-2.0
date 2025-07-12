import { parseISO, isAfter } from 'date-fns';

export const events = [
  {
    id: 1,
    title: {
      en: 'Gala Dinner 2025',
      fr: 'Dîner de Gala 2025'
    },
    date: '2025-09-30',
    description: {
      en: 'An unforgettable evening of elegance and style.',
      fr: 'Une soirée inoubliable d\'élégance et de style.'
    }
  },
  {
    id: 2,
    title: {
      en: 'Spring Fashion Show',
      fr: 'Défilé de Mode Printemps'
    },
    date: '2024-04-10',
    description: {
      en: 'Experience the latest trends in luxury fashion.',
      fr: 'Découvrez les dernières tendances de la mode de luxe.'
    }
  }
];

export function splitEvents(eventsList, today = new Date()) {
  const active = [];
  const archived = [];

  eventsList.forEach(e => {
    if (isAfter(parseISO(e.date), today)) active.push(e);
    else archived.push(e);
  });

  return { active, archived };
}
