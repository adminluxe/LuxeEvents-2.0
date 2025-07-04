import { useState } from 'react'
import { Dialog } from '@headlessui/react'
import { Menu, X } from 'lucide-react'

export default function MobileMenu() {
  let [open, setOpen] = useState(false)
  return (
    <>
      <button onClick={() => setOpen(true)} className="md:hidden p-2">
        <Menu className="text-ivory" />
      </button>
      <Dialog open={open} onClose={() => setOpen(false)} className="fixed inset-0 z-50">
        <Dialog.Overlay className="fixed inset-0 bg-black/70" />
        <div className="relative bg-ivory w-3/4 max-w-xs h-full p-6 shadow-xl transform transition-transform duration-500 ease-in-out"
             style={{ transform: open ? 'translateX(0)' : 'translateX(-100%)' }}>
          <div className="flex justify-between items-center mb-8">
            <div className={`text-3xl font-bold text-gold transition-transform duration-500 ${open?'rotate-360':''}`}>✨</div>
            <button onClick={() => setOpen(false)}>
              <X />
            </button>
          </div>
          <nav className="flex flex-col space-y-6 uppercase text-noir font-bold">
            {[
              ['Home', '#hero'],
              ['Galerie', '#gallery'],
              ['Haute Couture', '#barocco'],
              ['Témoignages', '#testimonials'],
            ].map(([label, href]) => (
              <a key={label} href={href} className="hover:text-gold transition">
                {label}
              </a>
            ))}
          </nav>
        </div>
      </Dialog>
    </>
  )
}
