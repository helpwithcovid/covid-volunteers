# Theming HelpWith

You can add your own look & feel on top of the HelpWith platform in three ways:

1) General configuration options in theme/config.rb.
1) Tweaking colors in theme/tailwind.colors.js.
2) Overwriting specific i18n keys in theme/locales.
3) Overwriting specific views in theme/views.

## General configuration options

theme/config.rb sets up some important variables

## Tweaking colors

[@jamie add content here]

## Tweaking i18n keys

Changing bits of text from the default views is easy, find any key in config/locales/en.yml and overwrite it with new text under themes/locales/en.yml.

## Tweaking views

There are some views that you will most likely always want to change. These are:

1) views/layouts/_head_content
2) views/home/index
3) views/home/about

In general it's best to avoid overwriting lots of views because that would make updates harder.
