import React from 'react'
import Navbar from './components/Navbar'
import Hero from './components/Hero'
import Gallery from './components/Gallery'
import Testimonials from './components/Testimonials'
import ContactForm from './components/ContactForm'
import { Link } from 'react-router-dom'

export default function App(){
  return(
    <div className="min-h-screen bg-site-hero bg-cover bg-center">
      <Navbar/>
      <main className="px-4 md:px-8 lg:px-16 text-luxeWhite space-y-16 mt-24">
        <Hero/>
        <Link to="/moments"><Gallery/></Link>
        <Link to="/temoignages"><Testimonials/></Link>
        <Link to="/contact"><ContactForm/></Link>
      </main>
    </div>
  )
}
