FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Book.title + "#{n}" }
    description { Faker::Quote.yoda }
    user
  end
end

