ALL_SKILLS = [ 'Software', 'Biology', 'Biotech', 'Medicine', 'Mechanics & Electronics', 'Funding', 'Content',  'Manufacturing', 'PM', 'Anything' ].freeze
ALL_AVAILABILITY = [ '1-2 hours a day', '2-4 hours a day', '4+ hours a day', 'Only on Weekends', 'Full Time' ].freeze
ALL_NUMBER_OF_VOLUNTEERS = [ '1-10', '10-50', '50-100', '100+' ]

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

PROJECT_SORT_HASH = {
  latest_up:        'created_at ASC, highlight DESC',
  latest_down:      'created_at DESC, highlight DESC',
  volunteers_up:    'number_of_volunteers ASC, highlight DESC',
  volunteers_down:  'number_of_volunteers DESC, highlight DESC',
  default:          'highlight DESC, COUNT(volunteers.id) DESC, created_at DESC'
}

VOLUNTEERS_SORT_HASH = {
  latest_up:        'created_at ASC',
  latest_down:      'created_at DESC',
  default:          'created_at DESC'
}


VOLUNTEERS_REQUIRED_FOR_FUNDING = 50
MAX_VOLUNTEERS_FOR_HIGHLIGHT_OFFER = 30
