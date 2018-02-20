FactoryBot.define do
  factory :action do
    action_type 'reading'
    description Faker::Company.bs
    lesson
    user
  end
end
