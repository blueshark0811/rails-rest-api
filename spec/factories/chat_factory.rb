FactoryBot.define do
  factory :chat do
    organization

    title Faker::Lorem.sentence
  end
end
