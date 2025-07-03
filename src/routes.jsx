import React from 'react'
import { Routes, Route, Navigate } from 'react-router-dom'
import Landing from './pages/Landing'
import MomentsPage from './pages/MomentsPage'
import GalleryDetail from './pages/GalleryDetail'
import Reserve from './pages/Reserve'
import TestimonialsPage from './pages/TestimonialsPage'
import ContactPage from './pages/ContactPage'

// Admin Guard example:
// const jwt = localStorage.getItem('jwt')

export default function Router() {
  return (
    import Layout from "./components/Layout";

<Routes>
    <Route path="/prestations" element={<Prestations/>} />
    <Route path="/contact" element={<Contact/>} />
    <Route path="/admin/login" element={<Layout><AdminLogin/>} />
    <Route path="/admin/*" element={<Layout><PrivateRoute><AdminDashboard/></PrivateRoute>} />
    <Route path="/reserver" element={<Layout><ReservationForm/>} />
    <Route path="/detail/:slug" element={<Layout><GalleryDetail/>} />
      <Route path="/" element={<Layout><Landing />} />
      <Route path="/moments" element={<Layout><MomentsPage />} />
      <Route path="/moments/:slug" element={<Layout><GalleryDetail />} />
      <Route path="/reserver" element={<Layout><Reserve />} />
      <Route path="/temoignages" element={<Layout><TestimonialsPage />} />
      <Route path="/contact" element={<Layout><ContactPage />} />
      {/*
      <Route
        path="/admin-area"
        element={jwt ? <AdminPage /> : <Navigate to="/" replace />}
      />
      */}
    </Routes>
  )
}
