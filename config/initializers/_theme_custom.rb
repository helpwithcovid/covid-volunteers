# This file is loaded when Rails boots during config/initializers.
# Set up default variables based on our `settings.yml`

Settings.add_source!("#{Rails.root}/theme/settings.yml")
Settings.reload!
