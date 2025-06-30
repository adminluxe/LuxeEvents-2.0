import React from 'react'
import { Routes,Route } from 'react-router-dom'
import App from './App'
import Reserve from './pages/Reserve'
import GalleryDetail from './pages/GalleryDetail'
import TestimonialsPage from './pages/TestimonialsPage'
import ContactPage from './pages/ContactPage'
export default function Router(){
  return(
    <Routes>
      <Route path="/" element={<App/>}/>
      <Route path="/reserver" element={<Reserve/>}/>
      <Route path="/moments" element={<GalleryDetail/>}/>
      <Route path="/temoignages" element={<TestimonialsPage/>}/>
      <Route path="/contact" element={<ContactPage/>}/>
    </Routes>
  )
}
