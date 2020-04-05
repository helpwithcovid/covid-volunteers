const plugin = require('tailwindcss/plugin')

module.exports = {
  theme: {
    extend: {},
    container: {
      center: true,
    },
    fontFamily: {
      sans: 'Roboto, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"',
    },
  },
  variants: {
    translate: ['responsive', 'hover', 'focus', 'group-hover'],
  },
  plugins: [
    require('@tailwindcss/ui'),
    /*
    * Spacing utilities
    * Ex: .space-y-bottom-2 space-x-right-4
    */
    plugin(function({ addUtilities, theme }) {
      const property = 'margin'
      const axes = ['x', 'y']
      const directions = {
        x: ['right', 'left'],
        y: ['top', 'bottom'],
      }
      let utilities = {}

      axes.forEach((axis) => {
        directions[axis].forEach((direction) => {
          const spacing = []

          Object.keys(theme('spacing')).filter((key) => {
            // fetching only the absolute values (numbers, no 1/2, 3/5, etc.)
            if (!key.includes('/')) {
              spacing[key] = theme('spacing')[key];
            }
          })

          Object.keys(spacing).forEach((key) => {
            const value = spacing[key]
            const className = `.space-${axis}-${direction}-${key}`

            const childrenProperties = {}
            childrenProperties[`${property}-${direction}`] = value

            const properties = {
              '>*' : childrenProperties,
            }
            utilities[className] = properties
          })
        })
      })

      addUtilities(utilities, {variants: ['responsive']})
    }),
  ],
}
