# Theming HelpWith

You can add your own look & feel on top of the HelpWith platform in three ways:

1) General configuration options in theme/settings.yml.
1) Tweaking colors in theme/tailwind.colors.js.
2) Overwriting specific i18n keys in theme/locales.
3) Overwriting specific views in theme/views.

## General configuration options

`theme/settings.yml` contains most of the configuration variables you need to set up.

## Tweaking colors

`tailwind.config.js` contains the major colors and fonts used throughout the app. Most important is simply
the `primary` and `secondary` colors.

You may change the apps color scheme using `/theme/tailwind.config.yml` file.

You may use one of tailwind's default colors by passing the color name like so:

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
    ...
```

## Tweaking i18n keys

Changing bits of text from the default views is easy, find any key in config/locales/en.yml and overwrite
it with new text under themes/locales/en.yml.

## Tweaking views

There are some views that you will most likely always want to change. These are:

1) views/layouts/_head_content (this is super important, where you'll change the title/description/icons/etc)
2) views/home/index
3) views/home/about

In general it's best to avoid overwriting lots of views because that would make updates harder.
