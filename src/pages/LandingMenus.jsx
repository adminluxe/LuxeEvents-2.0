import React from 'react'
import MenuCard from '../components/landing/MenuCard'

// Données extraites du devis PDF
const menus = [
  {
    title: 'Menu Ouest africain',
    img: '/menus/ouest.jpg',
    items: [
      'Pastels sénégalais & accras de crevettes',
      'Poulet Yassa, riz Jollof & alloco',
      'Salade de fruits tropicaux & bananes flambées'
    ],
    note: 'Option sans gluten disponible'
  },
  {
    title: 'Menu Cameroun / Centre',
    img: '/menus/centre.jpg',
    items: [
      'Beignets de manioc & brochettes d’agneau',
      'Poulet DG, fufu & attiéké',
      'Koki & fruits frais'
    ],
    note: 'Adaptable sans gluten'
  },
  {
    title: 'Menu Mix Ouest-Centre',
    img: '/menus/mix.jpg',
    items: [
      'Samoussas végétariens & plantain farci',
      'Mafé & brochettes de poisson, riz parfumé',
      'Thiakry & sablés à la noix de coco'
    ],
    note: 'Option vegane possible'
  }
]

export default function LandingMenus() {
  return (
    <section className="py-16 bg-gray-50">
      <h2 className="text-3xl font-serif text-center mb-8">Suggestions de menus</h2>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 px-4">
        {menus.map(m => (
          <MenuCard key={m.title} {...m} />
        ))}
      </div>
    </section>
  )
}
