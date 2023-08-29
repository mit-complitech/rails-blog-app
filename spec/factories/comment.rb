FactoryBot.define do
  factory :comment do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.sentence(word_count: 10) }
		commentable_id { Factory.create(:article).id }
		commentable_Type { "Article" }
		user_id { Factory.create(:user).id }
  end
end
