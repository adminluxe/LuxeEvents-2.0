import React from 'react'

export default function Button({ children, className = '', ...props }) {
  return (
    <button
      className={`bg-luxeGold text-luxeBlack font-semibold px-4 py-2 rounded-2xl shadow hover:scale-105 transition-transform ${className}`}
      {...props}
    >
      {children}
    </button>
  )
}
