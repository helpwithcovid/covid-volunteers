# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create!(
  email: 'bobsmith321@gmail.com',
  name: 'Bob Smith',
  password: 'password',
  password_confirmation: 'password',
  about: 'about section',
  location: 'location section',
  remote_location: 'remote location section',
  profile_links: 'github.com',
  visibility: true,
  level_of_availability: '2-4 hours a day'
)

user2 = User.create!(
  email: 'jillbob321@gmail.com',
  name: 'Jill Bob',
  password: 'password',
  password_confirmation: 'password',
  about: 'about section',
  location: 'location section',
  profile_links: 'github.com',
  visibility: true,
  level_of_availability: '99-100 hours a day'
)

user3 = User.create!(email: 'iamuser3@gmail.com', name: 'Luv2Code', password: 'password', password_confirmation: 'password')
user4 = User.create!(email: 'iamuser4@gmail.com', name: 'rspineanu', password: 'password', password_confirmation: 'password')
user5 = User.create!(email: 'iamuser5@gmail.com', name: 'cpu', password: 'password', password_confirmation: 'password')
user6 = User.create!(email: 'iamuser6@gmail.com', name: 'jamiew', password: 'password', password_confirmation: 'password')


# PROJECTS
project1 = Project.create(user: user, name: 'Act Now Foundation - Import & distribution of 10-minute at home COVID-19 test kits', location: 'New Haven (on site)', description: 'A cool description', highlight: true)

project2 = Project.create(
  user: user2,
  name: 'One Gazillion Masks',
  location: 'Remote',
  description: 'A cool description',
  highlight: true)

project3 = Project.create(user: user, name: 'Virtual homework supervision to help overwhelmed parents while school is closed project', location: 'New Haven (on site)', description: 'With elementary schools suddenly closed for the rest of the year, parents are struggling to balance work, caring for others and the sudden responsibility for keeping their children educated and on track for school.', highlight: false)

project4 = Project.create(user: user, name: 'Resistbot', location: 'Remote', description: %{Resistbot is a multipurpose and multifunction chatbot. Right now it's the easiest way to lobby both federal and state officials who are currently crafting a legislative response to the pandemic. Our end goal is to give everyone a voice and able to fight for what they want to see, no matter what it is, from social distancing measures at the state level, to federal UBI stimulus, to no corporate bailouts, to more health care supplies, and more. We've also just built covid-19 specific functionality to inform users of a variety of important information for their home state.}, highlight: true)

project5 = Project.create(user: user, name: 'Selfie lenses to spread public health into in a fun way project ', location: 'Remote', description: %{We are a group called Lefty Lenses who have been applying selfie lenses (like the Snapchat puppy filter) to politics for the 2020 election. Our lenses have reached 125M people in 10 weeks, and we've spent $0.}, highlight: false)

# VOLUNTEERS
project1.volunteered_users << user3
project3.volunteered_users << user
project3.volunteered_users << user2
project3.volunteered_users << user3
project3.volunteered_users << user4

# SKILLS
project1.skill_list.add('Design')
project1.save

# PROJECT CATEGORIES/PROBLEMS
project1.project_type_list.add('Access to car')
project5.project_type_list.add('CPR certificate')
project2.project_type_list.add('Languages other than English')

project1.project_type_list.add('Software programming')
project3.project_type_list.add('Data management')
project4.project_type_list.add('Web development')

project3.project_type_list.add('Access to car')
project4.project_type_list.add('Arts and crafts')
project1.project_type_list.add('Driver\'s License')
project5.project_type_list.add('Tutoring')

project1.save
project2.save
project3.save
project4.save
project5.save