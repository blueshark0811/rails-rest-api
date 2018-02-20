FactoryBot.define do
  factory :lesson do
    status 'active'
    title Faker::Company.name
    description Faker::Company.bs
    course
    user
  end
end
