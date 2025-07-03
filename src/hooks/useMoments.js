import { useState, useEffect } from 'react'
import axios from 'axios'

const API = import.meta.env.VITE_CMS_URL

export function useMoments() {
  const [moments, setMoments] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    axios
      .get(\`\${API}/api/moments?populate=thumbnail\`)
      .then(({ data }) => {
        setMoments(
          data.data.map(item => ({
            id: item.id,
            title: item.attributes.title,
            theme: item.attributes.theme,
            thumbnail: item.attributes.thumbnail.data.attributes.url,
            slug: item.attributes.slug,
          }))
        )
      })
      .catch(err => console.error(err))
      .finally(() => setLoading(false))
  }, [])

  return { moments, loading }
}
