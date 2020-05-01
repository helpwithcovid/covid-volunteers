# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'test123@gmail.com',
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
