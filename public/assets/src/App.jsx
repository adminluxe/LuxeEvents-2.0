import Hero from './components/Hero'
 import Gallery from './components/Gallery'
+import Videos from './components/Videos'
 import WhyChooseUs from './components/WhyChooseUs'
 import Testimonials from './components/Testimonials'
 import Contact from './components/Contact'

 export default function App() {
   return (
     <div className="font-sans">
       <Hero />
       <Gallery />
+      <Videos />
       <WhyChooseUs />
       <Testimonials />
       <Contact />
     </div>
   )
 }
