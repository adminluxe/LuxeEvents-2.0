import { useState, useEffect } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export function useTestimonials() {
  const [testimonials, setTestimonials] = useState([])
  useEffect(() => {
    axios.get(\`\${API}/api/testimonials?populate=photo\`)
      .then(({ data }) => setTestimonials(data.data))
      .catch(console.error)
  }, [])
  return testimonials
}
