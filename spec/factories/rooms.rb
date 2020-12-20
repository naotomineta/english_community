FactoryBot.define do
  factory :room do
    title { "welcome" }
    content { Faker::Lorem.sentence}
    toeic_id { 400 }
    association :user
  end
end
