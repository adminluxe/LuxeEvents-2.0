import React from 'react';
import { useTranslation } from 'react-i18next';
import styled from 'styled-components';
import { events, splitEvents } from '../utils/eventsData.js';

const Container = styled.div`
  padding: 2rem;
  max-width: 900px;
  margin: 0 auto;
`;

const Section = styled.section`
  margin-bottom: 3rem;
`;

const Title = styled.h2`
  border-bottom: 2px solid #aaa;
  padding-bottom: 0.5rem;
  margin-bottom: 1rem;
`;

const EventCard = styled.div`
  background: #f8f8f8;
  border-radius: 8px;
  padding: 1rem 1.5rem;
  margin-bottom: 1rem;
  box-shadow: 0 0 6px rgba(0,0,0,0.05);

  h3 {
    margin: 0;
  }
`;

export default function Events() {
  const { t, i18n } = useTranslation();
  const { active, archived } = splitEvents(events);

  return (
    <Container>
      <h1>{t('events')}</h1>

      <Section>
        <Title>{t('activeEvents')}</Title>
        {active.length === 0 && <p>{i18n.language === 'fr' ? 'Aucun événement actif pour le moment.' : 'No active events at the moment.'}</p>}
        {active.map(e => (
          <EventCard key={e.id}>
            <h3>{e.title[i18n.language]}</h3>
            <p>{e.description[i18n.language]}</p>
            <small>{new Date(e.date).toLocaleDateString(i18n.language)}</small>
          </EventCard>
        ))}
      </Section>

      <Section>
        <Title>{t('archivedEvents')}</Title>
        {archived.length === 0 && <p>{i18n.language === 'fr' ? 'Aucun événement archivé.' : 'No archived events.'}</p>}
        {archived.map(e => (
          <EventCard key={e.id}>
            <h3>{e.title[i18n.language]}</h3>
            <p>{e.description[i18n.language]}</p>
            <small>{new Date(e.date).toLocaleDateString(i18n.language)}</small>
          </EventCard>
        ))}
      </Section>
    </Container>
  );
}
