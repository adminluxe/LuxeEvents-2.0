import React from 'react'
import { Card, CardContent } from '@/components/ui/card'
import { motion } from 'framer-motion'

export default function FeatureCard({ title, img, children }) {
  return (
    <motion.div whileHover={{ scale: 1.05 }} className="w-full">
      <Card className="overflow-hidden">
        <img src={img} alt={title} className="w-full h-48 object-cover" loading="lazy" />
        <CardContent className="p-4">
          <h3 className="font-bold mb-2">{title}</h3>
          <p>{children}</p>
        </CardContent>
      </Card>
    </motion.div>
  )
}
