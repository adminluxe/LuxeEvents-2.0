import React from 'react'
import { motion } from 'framer-motion'

export default function Card({ children, className = '' }) {
  return (
    <motion.div
      className={`bg-white rounded-lg shadow p-6 ${className}`}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4 }}
    >
      {children}
    </motion.div>
  )
}
