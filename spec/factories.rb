FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "awesome1"
	end

	factory :quiz do
		name { Faker::Address.street_name }
		duration { rand(15) + 1 }
		release_date { Time.now }
		close_date { Time.now + 1000 }
	end

	factory :question do
		name { Faker::Address.street_name }
		content { Faker::Lorem.sentence(word_count = 5, supplemental = false ) }
		points 5
	end
end