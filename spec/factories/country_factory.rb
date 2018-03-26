FactoryBot.define do
  factory :country do
    code Faker::Address.country_code
    name { Faker::Address.country }
    phonecode Faker::Number.number(3)
  end
end
