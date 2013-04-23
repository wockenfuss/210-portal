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

	factory :gradebook do
		user_id 1
	end

	factory :attempt do
		start_time { Time.now }
		end_time { Time.now }
		quiz_id 1
		user_id 1
		graded false
	end

	factory :response do
		answer_id nil
		question_id 1
		attempt_id 1
		user_id 1
		content { Faker::Lorem.sentence(word_count = 5, supplemental = false ) }
		points 0
	end

	factory :answer do
		content { Faker::Lorem.sentence(word_count = 3, supplemental = false ) }
		question_id 1
		index_number 1
	end

end