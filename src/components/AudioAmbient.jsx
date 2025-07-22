import React from 'react'

const AudioAmbient = () => {
  return (
    <audio
      autoPlay
      muted
      loop
      playsInline
      preload="auto"
      src="/audio/ambiance-luxe.mp3"
      id="bg-audio"
    />
  )
}

export default AudioAmbient
