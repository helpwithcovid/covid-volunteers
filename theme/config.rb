# This file is loaded when Rails boots during config/initializers.
# Set up default variables based on our `settings.yml`

Settings.add_source!("#{Rails.root}/theme/settings.yml")
Settings.reload!

ALL_FEATURES = Settings.features_enabled.to_hash.map{|k,v| k.to_s if v == true }.freeze
ALL_SKILLS = Settings.volunteer_skills.freeze
ALL_AVAILABILITY = Settings.volunteer_availabilities.freeze
ALL_NUMBER_OF_VOLUNTEERS = Settings.volunteers_needed_for_project.freeze
ALL_PROJECT_TYPES = Settings.project_types.freeze
ALL_PROJECT_STATUS = Settings.project_statuses.freeze
ALL_ORGANIZATION_STATUS = Settings.organization_statuses.freeze
DISCORD_LINK = Settings.discord_link
MAX_VOLUNTEERS_FOR_HIGHLIGHT_OFFER = Settings.max_volunteers_for_highlight_offer
