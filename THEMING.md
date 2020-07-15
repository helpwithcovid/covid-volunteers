# Theming HelpWith

You can add your own look & feel on top of the HelpWith platform in three ways:

1) General configuration options in theme/config.rb.
1) Tweaking colors in theme/tailwind.colors.js.
2) Overwriting specific i18n keys in theme/locales.
3) Overwriting specific views in theme/views.

## General configuration options

`theme/config.rb` sets up some important variables (TODO explain which are important)

## Tweaking colors

`tailwind.config.js` contains the major colors and fonts used throughout the app. Most important is simply
the `primary` and `secondary` colors.

You may change the apps color scheme using `/theme/tailwind.config.yml` file.

For `primary` and `secondary` you may use one of tailwind's default colors by passing the color name like so:

```yaml
colors:
  primary: 'tailwind/ui/indigo'
```

You may declare your own colors from 50 -> 900 (increments of 100)

```yaml
colors:
  primary:
    50: '#fdf2f8'
    100: '#fce8f3'
    200: '#fad1e8'
    300: '#f8b4d9'
    400: '#f17eb8'
    500: '#e74694'
    600: '#d61f69'
    700: '#bf125d'
    800: '#99154b'
    900: '#751a3d'
```

Because the each theme has it's own accent colors in miscellaneous places throughout the app there's an `accent` value with it's own special attributes. The value of these attributes must be valid color names or codes.

```yaml
colors:
  accent:
    default: '#FFCE3D' # button background
    text: '#000' # button text
    border: '#8e4b10' # button border
    hover: '#ffe085' # button :hover background
    active: '#8e4b10' # button :active background
    focus: '#8e4b10' # button :focus background
```

## Tweaking i18n keys

Changing bits of text from the default views is easy, find any key in config/locales/en.yml and overwrite
it with new text under themes/locales/en.yml.

## Tweaking views

There are some views that you will most likely always want to change. These are:

1) views/layouts/_head_content
2) views/home/index
3) views/home/about

In general it's best to avoid overwriting lots of views because that would make updates harder.


# TODO

* how to customize logo (e.g. use `theme/logo.svg` and add logic to check for that?)
* how to customize site name? meta/og descriptions? can probably add to i18n
* any need to turn some features on or off?


## Tailwind UI default colors

```js
{
  transparent: 'transparent',
  white: '#ffffff',
  black: '#000000',
  gray: {
    '50': '#f9fafb',
    '100': '#f4f5f7',
    '200': '#e5e7eb',
    '300': '#d2d6dc',
    '400': '#9fa6b2',
    '500': '#6b7280',
    '600': '#4b5563',
    '700': '#374151',
    '800': '#252f3f',
    '900': '#161e2e'
  },
  'cool-gray': {
    '50': '#fbfdfe',
    '100': '#f1f5f9',
    '200': '#e2e8f0',
    '300': '#cfd8e3',
    '400': '#97a6ba',
    '500': '#64748b',
    '600': '#475569',
    '700': '#364152',
    '800': '#27303f',
    '900': '#1a202e'
  },
  red: {
    '50': '#fdf2f2',
    '100': '#fde8e8',
    '200': '#fbd5d5',
    '300': '#f8b4b4',
    '400': '#f98080',
    '500': '#f05252',
    '600': '#e02424',
    '700': '#c81e1e',
    '800': '#9b1c1c',
    '900': '#771d1d'
  },
  orange: {
    '50': '#fff8f1',
    '100': '#feecdc',
    '200': '#fcd9bd',
    '300': '#fdba8c',
    '400': '#ff8a4c',
    '500': '#ff5a1f',
    '600': '#d03801',
    '700': '#b43403',
    '800': '#8a2c0d',
    '900': '#771d1d'
  },
  yellow: {
    '50': '#fdfdea',
    '100': '#fdf6b2',
    '200': '#fce96a',
    '300': '#faca15',
    '400': '#e3a008',
    '500': '#c27803',
    '600': '#9f580a',
    '700': '#8e4b10',
    '800': '#723b13',
    '900': '#633112'
  },
  green: {
    '50': '#f3faf7',
    '100': '#def7ec',
    '200': '#bcf0da',
    '300': '#84e1bc',
    '400': '#31c48d',
    '500': '#0e9f6e',
    '600': '#057a55',
    '700': '#046c4e',
    '800': '#03543f',
    '900': '#014737'
  },
  teal: {
    '50': '#edfafa',
    '100': '#d5f5f6',
    '200': '#afecef',
    '300': '#7edce2',
    '400': '#16bdca',
    '500': '#0694a2',
    '600': '#047481',
    '700': '#036672',
    '800': '#05505c',
    '900': '#014451'
  },
  blue: {
    '50': '#ebf5ff',
    '100': '#e1effe',
    '200': '#c3ddfd',
    '300': '#a4cafe',
    '400': '#76a9fa',
    '500': '#3f83f8',
    '600': '#1c64f2',
    '700': '#1a56db',
    '800': '#1e429f',
    '900': '#233876'
  },
  indigo: {
    '50': '#f0f5ff',
    '100': '#e5edff',
    '200': '#cddbfe',
    '300': '#b4c6fc',
    '400': '#8da2fb',
    '500': '#6875f5',
    '600': '#5850ec',
    '700': '#5145cd',
    '800': '#42389d',
    '900': '#362f78'
  },
  purple: {
    '50': '#f6f5ff',
    '100': '#edebfe',
    '200': '#dcd7fe',
    '300': '#cabffd',
    '400': '#ac94fa',
    '500': '#9061f9',
    '600': '#7e3af2',
    '700': '#6c2bd9',
    '800': '#5521b5',
    '900': '#4a1d96'
  },
  pink: {
    '50': '#fdf2f8',
    '100': '#fce8f3',
    '200': '#fad1e8',
    '300': '#f8b4d9',
    '400': '#f17eb8',
    '500': '#e74694',
    '600': '#d61f69',
    '700': '#bf125d',
    '800': '#99154b',
    '900': '#751a3d'
  }
}
```