FactoryBot.define do
  factory :city do
    state
    country

    name { Faker::Address.city }
  end
end
