import { VitePWA } from 'vite-plugin-pwa';
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [
VitePWA({       registerType: 'autoUpdate',       manifest: {         name: 'LuxeEvents', short_name: 'Luxe',         theme_color: '#D4AF37', background_color: '#FFFFF0',         icons:[{src:'/favicon-gold-192.png',sizes:'192x192',type:'image/png'},{src:'/favicon-gold-512.png',sizes:'512x512',type:'image/png'}],         splash_pages: 'all'       }     }),
VitePWA({       registerType: 'autoUpdate',       manifest: {         name: 'LuxeEvents', short_name: 'Luxe',         theme_color: '#D4AF37', background_color: '#FFFFF0',         icons:[{src:'/favicon-gold-192.png',sizes:'192x192',type:'image/png'},{src:'/favicon-gold-512.png',sizes:'512x512',type:'image/png'}],         splash_pages: 'all'       }     }),
    VitePWA({ registerType: 'autoUpdate', manifest: { name: 'LuxeEvents', short_name: 'Luxe', theme_color: '#D4AF37', background_color: '#FFFFF0', icons: [ { src: '/favicon-gold-192.png', sizes: '192x192', type: 'image/png' }, { src: '/favicon-gold-512.png', sizes: '512x512', type: 'image/png' } ] } }),
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'LuxeEvents',
        short_name: 'Luxe',
        icons: [ /* icônes or 192/512 */ ],
        theme_color: '#D4AF37',
        background_color: '#FFFFF0',
        display: 'standalone',
      },
    }),
  ],
})
