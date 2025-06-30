/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html','./src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
        luxeGold:   '#C9A66B',
        luxeBlack:  '#1A1A1A',
        gold:       '#D4AF37',
        yellow:     '#FFD700',
        ivory:      '#F7F1E1',
        luxeWhite:  '#FFFFFF',
      },
      backgroundImage: {
        'site-hero': "url('/assets/image1.jpg')",
      },
      fontFamily: {
        serif: ['Playfair Display','serif'],
        sans:  ['Inter','sans-serif'],
      },
    },
  },
  plugins: [ require('@tailwindcss/typography') ],
}
