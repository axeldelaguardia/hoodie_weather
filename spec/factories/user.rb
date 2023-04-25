FactoryBot.define do
	factory :user do
		email { Faker::Internet.email }
		password { Faker::Internet.password }
		api_key { Faker::Internet.password }
	end
end