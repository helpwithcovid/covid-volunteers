# frozen_string_literal: true

FactoryBot.define do
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
  end

  factory :user_complete_profile, parent: :user do
    about { 'About' }
    profile_links { 'Profile' }
    location { 'location' }
  end

  factory :project do
    name { 'My First Project' }
    description { 'My description' }
    volunteer_location { 'location' }
    status { ALL_PROJECT_STATUS.first }
  end

  factory :project_with_type, parent: :project do
    project_type_list { ['Track the outbreak'] }
  end

  factory :volunteer do
    # ...
  end

  factory :offer do
    name { "Free Veggie Burgers" }
    description { "They're delicious and animal-free" }
    limitations { "Contains gluten" }
    redemption { "https://veggieboigas.com" }
    location { "N/A" }
  end
end
