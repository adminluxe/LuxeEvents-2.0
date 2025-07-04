/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx}"
  ],
  theme: {
    extend: {
      boxShadow: {
        'lux-soft': '0 4px 14px rgba(0, 0, 0, 0.1)',
        'lux-glow': '0 0 30px rgba(212, 175, 55, 0.6)',
      },
    },
  },
  plugins: [],
}
