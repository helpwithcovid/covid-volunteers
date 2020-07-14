# This file is loaded when Rails boots during config/initializers.
# Set up default variables based on our `settings.yml`

Settings.reload_from_files(
  Rails.root.join("theme", "settings.yml").to_s,
)
