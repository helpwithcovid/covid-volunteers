const plugin = require('tailwindcss/plugin')

module.exports = {
  theme: {
    extend: {
      colors: {
        smoke: 'rgba(0, 0, 0, 0.5)',
        'indigo-50': '#F9F9FF',
      },
      maxHeight: {
        '400px': '400px',
      },
      minHeight: {
        '400px': '400px',
      },
      boxShadow: {
        users: '0px 3px 16px rgba(0, 0, 0, 0.15)',
      }
    },
    container: {
      center: true,
    },
    fontFamily: {
      sans: 'Roboto, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"',
    },
  },
  variants: {
    translate: ['responsive', 'hover', 'focus', 'group-hover'],
    display: ['responsive', 'hover', 'focus', 'group-hover'],
  },
  plugins: [
    require('@tailwindcss/ui'),
    /*
    * Spacing utilities
    * Ex: .space-y-bottom-2 space-x-right-4
    */
    plugin(function ({ addUtilities, theme }) {
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
              '>*': childrenProperties,
            }
            utilities[className] = properties
          })
        })
      })

      addUtilities(utilities, { variants: ['responsive'] })
    }),
    plugin(function ({ addUtilities, theme }) {

      const utilities = {
        '.grid-auto-row-1fr': {
          'grid-auto-rows': '1fr'
        }
      }

      addUtilities(utilities)
    }),
    // buttons
    plugin(function ({ addComponents, theme }) {
      const styles = {
        display: 'inline-block',
        fontSize: theme('fontSize.sm'),
        padding: `${theme('spacing.2')} ${theme('spacing.4')}`,
        fill: 'currentColor',
        whiteSpace: 'nowrap',
        backgroundColor: theme('colors.white'),
        color: theme('colors.gray.900'),
        border: `1px solid ${theme('colors.gray.100')}`,
        transitionProperty: theme('transitionProperty.default'),
        transitionDuration: theme('transitionDuration.100'),
        borderRadius: theme('borderRadius.default'),
        boxShadow: theme('boxShadow.default'),
        '&:hover': {
          backgroundColor: theme('colors.gray.100'),
        },
        '&:active': {
          backgroundColor: theme('colors.gray.200'),
        },
      }
      const buttons = {
        '@variants responsive': {
          '.button': {
            ...styles,
            '&.button-lg': {
              padding: `${theme('spacing.3')} ${theme('spacing.6')}`,
              fontSize: theme('fontSize.lg'),
            },
            '&.button-sm': {
              padding: `${theme('spacing.1')} ${theme('spacing.2')}`,
              fontSize: theme('fontSize.sm'),
            },
            '&.button-xl': {
              padding: `${theme('spacing.4')} ${theme('spacing.10')}`,
              fontSize: theme('fontSize.2xl'),
            },
          },
          '.button-indigo': {
            ...styles,
            color: theme('colors.white'),
            backgroundColor: theme('colors.indigo.600'),
            '&:hover': {
              backgroundColor: theme('colors.indigo.700'),
            },
            '&:active': {
              backgroundColor: theme('colors.indigo.800'),
            },
            '&1active': {
              backgroundColor: theme('colors.indigo.800'),
            },
          }
        },
      }

      addComponents(buttons)
    })
  ],
}
