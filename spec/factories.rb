FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "awesome1"
	end

	factory :quiz do
		name { Faker::Lorem.word }
		duration { rand(15) + 1 }
		release_date { Time.now }
		close_date { Time.now + 1000 }
	end
end