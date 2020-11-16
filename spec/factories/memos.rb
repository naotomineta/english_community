FactoryBot.define do
  factory :memo do
    content {Faker::Name.last_name}
    translation {Faker::Name.last_name}
    association :user
  end
end
