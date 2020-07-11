# This file is loaded when Rails boots during config/initializers.
# Set up default variables.

# Enabled features.
ALL_FEATURES = [
  'volunteer_directory',
  'resources',
  'office_hours',
  'success_stories'
].freeze

# These are the skills that volunteers can have and projects can request.
ALL_SKILLS = [
  'Analytics',
  'Biology',
  'Biotech',
  'Community Outreach',
  'Content',
  'Data entry',
  'Design',
  'Funding',
  'Helpdesk',
  'Legal',
  'Localization',
  'Manufacturing',
  'Marketing',
  'Medicine',
  'Mechanics & Electronics',
  'Operations',
  'PM',
  'QA',
  'Sales',
  'Social Media',
  'Software',
  'Training Development',
  'Volunteer vetting',
  'Anything'
].freeze

# Availability of volunteers.
ALL_AVAILABILITY = [
  '1-2 hours a day',
  '2-4 hours a day',
  '4+ hours a day',
  'Only on Weekends',
  'Full Time'
].freeze

# How many volunteers a project might request.
ALL_NUMBER_OF_VOLUNTEERS = [
  '1-10',
  '10-50',
  '50-100',
  '100+'
].freeze

# Project types.
ALL_PROJECT_TYPES = [
  'Track the outbreak',
  'Reduce spread',
  'Scale testing',
  'Medical facilities',
  'Medical equipments',
  'Treatment R&D',
  'E-Learning',
  'Job placement',
  'Mental health',
  'Help out communities',
  'Map volunteers to needs',
  'News and information',
  'Social giving',
  'Other'
].freeze

# Project statuses.
ALL_PROJECT_STATUS = [
  'Just started',
  'In progress',
  'Launched'
].freeze

# Project incorporation statuses.
ALL_ORGANIZATION_STATUS = [
  'Non-profit',
  'For-profit',
  'Not incorporated',
  'Public benefit cooperative'
].freeze

DISCORD_LINK = 'https://discord.gg/8nAJfFN'

# If a project has less than N volunteers
# it can ask to be highlighted.
MAX_VOLUNTEERS_FOR_HIGHLIGHT_OFFER = 30
