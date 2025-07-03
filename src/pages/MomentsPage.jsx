import React from 'react'
import MomentsWall from '../components/MomentsWall'
import { useMoments } from '../hooks/useMoments'

export default function MomentsPage() {
  const { moments, loading } = useMoments()

  return (
    <section className="space-y-6 px-4">
      <h1 className="text-4xl font-heading text-center mb-8">Moments d’Exception</h1>
      {loading ? (
        <p className="text-center">Chargement…</p>
      ) : (
        <MomentsWall moments={moments} />
      )}
    </section>
  )
}
