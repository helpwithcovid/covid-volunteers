# This file is loaded when Rails boots during config/initializers.
# Set up default variables based on our `settings.yml`

Settings.add_source!(Rails.root.join('theme', 'settings.yml').to_s)
Settings.reload!

all_project_types = Settings.project_categories.map do |category|
  category.project_types
end

Settings.add_source!({
  project_types: all_project_types.flatten,
})

Settings.reload!

require Rails.root.join('theme', 'initializer.rb').to_s
