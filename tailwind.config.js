/** @type {import('tailwindcss').Config} */
export default { darkMode: 'class',
  content: ['./index.html','./src/**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      boxShadow: {
        'lux-soft': '0 4px 14px rgba(0, 0, 0, 0.1)',
        'lux-glow': '0 0 30px rgba(212, 175, 55, 0.6)',
      },
      boxShadow: {
        'lux-light': '0 4px 6px rgba(0,0,0,0.06), 0 1px 3px rgba(0,0,0,0.1)',
        'lux-medium': '0 10px 15px rgba(0,0,0,0.1), 0 4px 6px rgba(0,0,0,0.05)',
        'lux-heavy': '0 20px 25px rgba(0,0,0,0.15), 0 8px 10px rgba(0,0,0,0.04)',
      },
      colors: {
        gold: '#D4AF37',
        ivory: '#FFFFF0',
        noir: '#000000',
      },
      fontFamily: {
        luxe: ['"Playfair Display"', 'serif'],
        sans: ['"Inter"', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
