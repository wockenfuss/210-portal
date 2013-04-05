FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "awesome1"
	end
end