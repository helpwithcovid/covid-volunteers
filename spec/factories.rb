# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    
  end

  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraphs(number: rand(4...20)).join("\n") }
    links { Faker::Internet.url }
  end

  factory :volunteer_group do
  end

  factory :user do
    name { 'Bob Isok' }
    sequence(:email) { |n|
      # puts "HI"; puts n.inspect; "user#{n}@example.com"
      gen = "user_#{rand(1000)}@factory.com"
      while User.where(email: gen).exists?
        gen = "user_#{rand(1000)}@factory.com"
      end
      gen
    }
    password { 'df823jls18fk350f' }

    factory :user_visible do
      visibility { true }
    end
  end

  factory :user_admin, parent: :user do
    email { 'email@address.com' } # should match .env.test
  end

  factory :user_complete_profile, parent: :user do
    about { 'About' }
    profile_links { 'Profile' }
    location { 'location' }
    skill_list { ['Analytics'] }
  end

  factory :project do
    name { 'My First Project' }
    description { 'My description' }
    volunteer_location { 'location' }
    status { Settings.project_statuses.first }
  end

  factory :project_with_type, parent: :project do
    project_type_list { ['Track the outbreak'] }
  end

  factory :volunteer do
    # ...
  end

  factory :offer do
    name { 'Free Veggie Burgers' }
    description { "They're delicious and animal-free" }
    limitations { 'Contains gluten' }
    redemption { 'https://veggieboigas.com' }
    location { 'N/A' }
  end
end
