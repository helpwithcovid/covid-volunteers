FactoryBot.define do

  factory :user do
    name { "Bob Isok" }
    email  { "spacecat@example.com" }
    password { "df823jls18fk350f" }
  end

	factory :project do
		name { "My First Project" }
	end

	factory :volunteer do
		# ...
	end

	factory :offer do
		# ...
	end

end