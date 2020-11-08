FactoryBot.define do
  factory :room do
    name { Faker::Team.name }
    toeic_id { 400 }
    association :user
  end
end
