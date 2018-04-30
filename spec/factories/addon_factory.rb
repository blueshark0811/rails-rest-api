FactoryBot.define do
  factory :addon do
    title Faker::Lorem.sentence
    description Faker::Lorem.sentence
  end
end
