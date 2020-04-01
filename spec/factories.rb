FactoryBot.define do
  factory :volunteer_group do
    
  end


  factory :user do
    name { "Bob Isok" }
    sequence(:email) {|n|
      # puts "HI"; puts n.inspect; "user#{n}@example.com"
      gen = "user_#{rand(1000)}@factory.com"
      while User.where(email: gen).exists?
        gen = "user_#{rand(1000)}@factory.com"
      end
      gen
    }
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