ALL_SKILLS = [ 'Analytics', 'Biology', 'Biotech', 'Content', 'Data entry', 'Design', 'Funding', 'Localization', 'Manufacturing', 'Marketing', 'Medicine', 'Mechanics & Electronics', 'Operations', 'PM', 'QA', 'Social Media', 'Software', 'Volunteer vetting', 'Anything' ].freeze
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

ALL_PROJECT_STATUS = [
  'Just started',
  'In progress',
  'Launched',
  'Actively recruiting'
].freeze

VOLUNTEERS_REQUIRED_FOR_FUNDING = 50
MAX_VOLUNTEERS_FOR_HIGHLIGHT_OFFER = 30

RESOURCE_ANNOUNCEMENTS = [
  {
    title: 'HWC Project & Volunteer Playbook',
    sub_title: 'A short guide created by our team to help you successfully manager your project and volunteers!',
    cta_text: 'Download Playbook',
    cta_url: "https://docs.google.com/document/d/1f_-g893NGawa5n4KyDw6zjrocO2VBS5b2siQIZ6csY0/view"
  },
  {
    title: 'Webinar on How to Scale Volunteers',
    sub_title: 'Glen Moriarty, founder of 7cups on how he manages 320k volunteers.',
    cta_text: 'View Recording',
    cta_url: "https://openai.zoom.us/rec/play/vZN-dbuq-m03TNKSsASDAfEtW466J6qs1XQWrvtYxRvmU3QDNVv0NLJGYbffjdiMo1gf68qHVnbe2mOi?continueMode=true"
  }
]

GLOBAL_ANNOUNCEMENTS = [
  {
    title: 'Resources for your project',
    sub_title: 'From webinars on How to Scale Volunteers, management playbook, to office hours, offers and more.',
    cta_text: 'View Resources',
    # TODO find a better way to pass this
    cta_url: 'offers'
  }
]
