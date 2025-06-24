module.exports = {
  content: ['./src/**/*.{js,jsx,ts,tsx}', './design-system/components/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        gold: colors.gold,
        ivory: colors.ivory,
      },
      fontFamily: {
        heading: font.heading,
        body: font.body,
      },
    },
  },
  plugins: [],
};
