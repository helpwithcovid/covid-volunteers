// Please read the Theming.md file on Tweaking colors before applying changes to this file.

const plugin = require('tailwindcss/plugin')
const uiColors = require('@tailwindcss/ui/colors')
const fs = require('fs')
const yaml = require('js-yaml')

// Fetching the theme config
let themeConfig
const themeFile = './theme/tailwind.config.yml'
try {
    let fileContents = fs.readFileSync(themeFile, 'utf8')
    themeConfig = yaml.safeLoad(fileContents)
} catch (e) {
    console.log(e)
}

// Setting defaults
let themeColors = {
  primary: uiColors.indigo,
  secondary: uiColors.purple,
  'cat-foobar': '#ffffff'
}

// adding accent colors
themeColors.accent = {
  default: themeColors.primary[600],
  text: uiColors.white.default,
  hover: themeColors.primary[500],
  border: themeColors.primary[700],
  active: themeColors.primary[700],
  focus: themeColors.primary[700],
  sub_navbar_bg: uiColors.white.default,
  sub_navbar_text: uiColors.black.default,
  filters_navbar_bg: themeColors.primary[100],
  filters_navbar_text: uiColors.black.default,
}

// Parsing the theme config
if (themeConfig && themeConfig.colors && Object.keys(themeConfig.colors).length > 0) {
  Object.keys(themeColors).forEach((colorKey) => {
    if (themeConfig.colors[colorKey]) {
      if (typeof themeConfig.colors[colorKey] === 'string') {
        if (themeConfig.colors[colorKey].startsWith('tailwind/ui/')) {
          const themedColor = themeConfig.colors[colorKey].replace('tailwind/ui/', '')
          themeColors[colorKey] = uiColors[themedColor]
        } else {
          themeColors[colorKey] = themeConfig.colors[colorKey]
        }
      // arbitrary checking if this object has keys 50 & 900 corresponding to the tailwind color system
      } else if (themeConfig.colors[colorKey][50] && themeConfig.colors[colorKey][900]) {
        themeColors[colorKey] = themeConfig.colors[colorKey]
      } else if (themeConfig.colors[colorKey] && Object.keys(themeConfig.colors[colorKey]).length > 0) {
        Object.keys(themeConfig.colors[colorKey]).forEach((themeConfigColorKey) => {
          const themedColor = themeConfig.colors[colorKey][themeConfigColorKey].replace('tailwind/ui/', '')

          themeColors[colorKey][themeConfigColorKey] = themedColor
        })
      }
    }
  })
}

module.exports = {
  theme: {
    extend: {
      spacing: {
        '2px': '2px',
      },
      colors: {
        ...themeColors,
        smoke: 'rgba(0, 0, 0, 0.5)',
        'hero-black': '#3D3D3D',
        'cat-education': '#F82B2B',
        'cat-social-justice': '#FD813B',
        'cat-business-directory': '#8921DC',
        'cat-health': '#2987DE',
        'cat-wealth': '#12CFA1',
      },
      maxHeight: {
        '400px': '400px',
      },
      minHeight: {
        '400px': '400px',
      },
      boxShadow: {
        users: '0px 3px 16px rgba(0, 0, 0, 0.15)',
      },
      borderRadius: {
        xl: '1.5rem',
      }
    },
    container: {
      center: true,
    },
    fontFamily: {
      sans: 'Roboto, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"',
      serif: '"Lora", Georgia, Cambria, "Times New Roman", Times, serif',
    },
  },
  variants: {
    translate: ['responsive', 'hover', 'focus', 'group-hover'],
    display: ['responsive', 'hover', 'focus', 'group-hover'],
    width: ['responsive', 'hover', 'focus', 'group-hover'],
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
        display: 'inline-flex',
        alignItems: 'center',
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
          '.button-primary': {
            ...styles,
            color: theme('colors.white'),
            backgroundColor: theme('colors.primary.600'),
            '&:hover': {
              backgroundColor: theme('colors.primary.700'),
            },
            '&:active': {
              backgroundColor: theme('colors.primary.800'),
            },
            '&1active': {
              backgroundColor: theme('colors.primary.800'),
            },
          }
        },
      }

      addComponents(buttons)
    })
  ],
}
