import React from 'react'

export default function Input({ label, error, className = '', ...props }) {
  return (
    <div className={className}>
      {label && <label className="block mb-1 font-medium">{label}</label>}
      <input {...props} className="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-luxeGold" />
      {error && <p className="text-red-600 text-sm mt-1">{error}</p>}
    </div>
  )
}
