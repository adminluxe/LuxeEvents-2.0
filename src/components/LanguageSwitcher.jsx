import React from 'react';
import { useTranslation } from 'react-i18next';
import styled from 'styled-components';

const Select = styled.select`
  background: transparent;
  border: 1px solid #ccc;
  padding: 4px 8px;
  border-radius: 4px;
  color: #333;
  cursor: pointer;
`;

export default function LanguageSwitcher() {
  const { i18n, t } = useTranslation();

  const changeLanguage = (e) => {
    i18n.changeLanguage(e.target.value);
  };

  return (
    <label>
      {t('language')}:{' '}
      <Select onChange={changeLanguage} value={i18n.language}>
        <option value="fr">FR</option>
        <option value="en">EN</option>
      </Select>
    </label>
  );
}
