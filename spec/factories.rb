FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "awesome1"
	end

	factory :quiz do
		name { Faker::Address.street_name }
		duration { rand(15) + 1 }
		release_date { Time.now }
		close_date { Time.now + 10000 }
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

	factory :unit do
		name { Faker::Lorem.sentence(word_count = 2, supplemental = false) }
		release_date { Time.now }
		close_date { Time.now + 10000 }
	end

	factory :lecture do
		name { Faker::Lorem.sentence(word_count = 2, supplemental = false) }
	end

	factory :comment do 
		commentable_id 1
		commentable_type "LectureQuestion"
		content { Faker::Lorem.sentence(word_count = 5, supplemental= false) }
		user_id 1
	end

	factory :component do
		component_index 1
		unit_id 1
	end

	factory :lecture_question do
		order_index 1
		lecture_id 1
		content { Faker::Lorem.sentence(word_count = 5, supplemental = false) }
	end

	factory :post do
		self.subject { Faker::Lorem.sentence(word_count = 2, supplemental = false) }
		content { Faker::Lorem.paragraph(sentence_count = 2, supplemental = false) }
		user_id 1
		commentable_id 1
		commentable_type "Discussion"
	end

	factory :discussion do
		content { Faker::Lorem.paragraph(sentence_count = 2, supplemental = false)}
		release_date { Time.now }
		name { Faker::Lorem.sentence(word_count = 2, supplemental = false)}
	end

end