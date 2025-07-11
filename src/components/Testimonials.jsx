import React from 'react'
import { testimonials } from '../data/testimonials'
import { useTranslation } from 'react-i18next'
import Card from './Card.jsx'

export default function Testimonials() {
  const { i18n } = useTranslation()
  return (
    <div className="testimonials-grid">
      {testimonials.map((t, i) => {
        const { name, text } = t[i18n.language]
        return (
          <Card key={i}>
            <blockquote>"{text}"</blockquote>
            <footer>— {name}</footer>
          </Card>
        )
      })}
    </div>
  )
}
