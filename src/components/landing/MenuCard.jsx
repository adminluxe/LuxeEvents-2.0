import React from 'react'
import { Card, CardContent } from '@/components/ui/card'
import { motion } from 'framer-motion'

export default function MenuCard({ title, img, items, note }) {
  return (
    <motion.div whileHover={{ scale: 1.03 }} className="max-w-sm">
      <Card className="overflow-hidden">
        <img src={img} alt={title} className="w-full h-48 object-cover" loading="lazy" />
        <CardContent className="p-4">
          <h3 className="text-xl font-semibold mb-2">{title}</h3>
          <ul className="list-disc list-inside mb-2">
            {items.map((it, i) => <li key={i}>{it}</li>)}
          </ul>
          {note && <p className="text-sm italic text-gray-500">{note}</p>}
        </CardContent>
      </Card>
    </motion.div>
  )
}
