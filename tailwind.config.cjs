/** @type {import('tailwindcss').Config} */
module.exports = {
  theme: { extend: { colors: { luxeGold: '#C9A66B', luxeBlack: '#1A1A1A' }, fontFamily: { serif: ['Playfair Display','serif'], sans: ['Inter','sans-serif'] } } },
  content: ['./index.html','./src/**/*.{js,jsx}'],
  theme: { extend: {} },
  plugins: [],
    require('@tailwindcss/typography'),
    require('@tailwindcss/typography'),
};
  theme: {
    extend: {
      colors: {
        luxeGold: '#C9A66B',
        luxeBlack: '#1A1A1A',
      },
      fontFamily: {
        serif: ['Playfair Display','serif'],
        sans: ['Inter','sans-serif'],
      },
    },
  },
