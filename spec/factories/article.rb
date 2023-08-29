FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.sentence(word_count: 10) }
		user_id { Factory.create(:user).id }
  end
end
