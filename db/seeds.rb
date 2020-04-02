# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
  email: 'user@gmail.com',
  name: 'Bob Smith',
  password: 'password',
  password_confirmation: 'password',
  about: 'about section',
  location: 'location section',
  profile_links: 'github.com',
  visibility: true,
  level_of_availability: '2-4 hours a day'
)

user2 = User.create!(
  email: 'user2@gmail.com',
  name: 'Jill Bob',
  password: 'password',
  password_confirmation: 'password',
  about: 'about section',
  location: 'location section',
  profile_links: 'github.com',
  visibility: true,
  level_of_availability: '99-100 hours a day'
)

user3 = User.create!(email: 'user3@gmail.com', name: 'Luv2Code', password: "password", password_confirmation: "password")
user4 = User.create!(email: 'user4@gmail.com', name: 'rspineanu', password: "password", password_confirmation: "password")
user5 = User.create!(email: 'user5@gmail.com', name: 'cpu', password: "password", password_confirmation: "password")
user6 = User.create!(email: 'user6@gmail.com', name: 'jamiew', password: "password", password_confirmation: "password")

project1 = Project.create(user: user, name: 'Act Now Foundation - Import & distribution of 10-minute at home COVID-19 test kits', description: 'A cool description', accepting_volunteers: true)
project1.skill_list.add('Design')
project1.save

project2 = Project.create!(user: user2, name: 'One Gazillion Masks', description: 'A cool description', accepting_volunteers: false)

project1.volunteered_users << user3