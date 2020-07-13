# Tailwind theming

You may change the apps color scheme using `/theme/tailwind.config.yml` file.

You may use one of tailwinds colors by passing the color name like so:

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