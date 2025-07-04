// src/components/Hero3D.jsx
import React, { Suspense, useRef } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { useGLTF, OrbitControls } from '@react-three/drei'

function Model({ hoverIntensity }) {
  // URL du sample CC0 DamagedHelmet
  const gltf = useGLTF(
    'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb'
  )
  const ref = useRef()
  useFrame((_, delta) => {
    if (ref.current) ref.current.rotation.y += delta * 0.2
    gltf.scene.traverse(child => {
      if (child.isMesh && child.material.emissive)
        child.material.emissiveIntensity = hoverIntensity.current
    })
  })
  return <primitive ref={ref} object={gltf.scene} />
}

export default function Hero3D() {
  const hoverIntensity = useRef(0.5)
  return (
    <Canvas style={{ height: '100vh', width: '100%' }} camera={{ position: [0, 1, 3], fov: 50 }}>
      <ambientLight intensity={0.3} />
      <spotLight position={[5, 5, 5]} angle={0.3} color="gold" intensity={hoverIntensity.current} />
      <spotLight position={[-5, 2, -5]} angle={0.3} color="turquoise" intensity={0.8} />

      <Suspense
        fallback={
          <mesh>
            <sphereGeometry args={[0.5, 32, 32]} />
            <meshStandardMaterial color="gray" />
          </mesh>
        }
      >
        <Model hoverIntensity={hoverIntensity} />
      </Suspense>

      <OrbitControls
        enableZoom={false}
        onPointerOver={() => (hoverIntensity.current = 1.2)}
        onPointerOut={() => (hoverIntensity.current = 0.5)}
      />
    </Canvas>
  )
}
