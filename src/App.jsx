import { Routes, Route } from 'react-router-dom'
import Layout from '@/components/Layout'
import Home from './pages/Home'
import About from './pages/About'
import Quote from './pages/Quote'
import Gallery from './pages/Gallery'
import './index.css'

export default function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/quote" element={<Quote />} />
        <Route path="/gallery" element={<Gallery />} />
      </Routes>
    </Layout>
  )
}
