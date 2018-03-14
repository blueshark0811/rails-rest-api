FactoryBot.define do
  factory :lesson do
    course
    user
    status 'active'
    title Faker::Company.name
    description Faker::Company.bs
  end
end
